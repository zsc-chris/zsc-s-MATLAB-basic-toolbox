function self=subsasgn(self,S,B)
%SUBSASGN	Subscripted assignment
%	Syntax: [...[.(...)/(...)/{...}]*?]=*... allows you to group
%	dimensions. For complete description see <a href="matlab:help
%	DNT/subsref -displayBanner">DNT/subsref</a>.
%
%	Note: parenDelete is not supported, as MATLAB's rule of deletion is not
%		well-defined.
%
%	See also DNT/subsref

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		S(1,:)struct
	end
	arguments(Input,Repeating)
		B
	end
	arguments(Output)
		self DNT
	end
	constructor=str2func(class(self));
	if S(1).type=="."
		if zsc.isproperty("DNT",S(1).subs)
			self=builtin("subsasgn",self,S,B{:});
		else
			self.data=builtin("subsasgn",gather(self),S,B{:});
		end
	else
		[self,subs]=parsedimargsindexing(self,S(1).subs,"subsasgn");
		if isscalar(S)&&S(1).type=="()"&&isequal(B,{[]})
			error("ZSC:DNT:subsasgn:parenDeleteNotSupported","Parenthesis deletion ...(...)=[] is not supported because its rule is not well-defined.")
		else
			ind=constructor(zsc.reshape(1:numel(self),size(self)),self.dimnames);
			S_=S(1);
			S_.type="()";
			ind=gather(subsref(ind,S_));
			if S(1).type=="()"
				ret=subsref(self,S_);
				for i=1:numel(B)
					if isa(B{i},"DNT")
						[~,B{i}]=feval(@deal,ret,squeeze(B{i},setdiff(ret.dimnames,B{i}.dimnames)));
						B{i}=gather(B{i});
					end
				end
				S_=S(2:end);
				if isempty(S_)
					ret.data=B{:};
				else
					try
						subsref(ret,S_,"DNTonly");
						ret=builtin("subsasgn",ret,S_,B{:});
					catch
						ret.data=builtin("subsasgn",gather(ret),S_,B{:});
					end
				end
				self.data(ind)=gather(ret);
			else
				ret=gather(subsref(self,S_));
				S_=S;
				S_(1).subs=repmat({':'},[1,ndims(ret)]);
				ret=subsasgn(ret,S_,B{:});
				self.data(ind)=ret;
			end
		end
	end
end