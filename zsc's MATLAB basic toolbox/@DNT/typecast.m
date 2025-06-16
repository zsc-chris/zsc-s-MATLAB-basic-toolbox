function ret=typecast(self,newclass,options)
%TYPECAST	Convert datatypes of DNT without changing underlying data
%	ret=TYPECAST(self,newclass)
%	ret=TYPECAST(self,*,like)
%
%	See also typecast, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT{mustBeTrue("@(self)self.ndims<=1||self.ndims<=2&&isempty(self)",self,VariableNames="self")}
		newclass(1,1)string=missing
		options.like
	end
	arguments(Output)
		ret
	end
	dstar=dstarclass;
	zsc.assert(nargin<2||isempty(fieldnames(options)),message("MATLAB:maxrhs"))
	if nargin<=1&&isempty(fieldnames(options))
		error(message("MATLAB:minrhs"))
	end
	if nargin==2
		if isempty(self)
			ret=cast(self,newclass);
			return
		end
		ret=feval(@(varargin)flatten(typecast(varargin{:})),self,AdditionalInput={newclass});
	else
		if isempty(self)
			ret=cast(self,dstar{options});
			return
		end
		if isa(options.like,"DNT")
			dim1=ndims(self);
			ret=feval(@(varargin)flatten(typecast(varargin{:})),self,AdditionalInput={"like",gather(options.like)});
			dim2=ndims(ret);
			if dim1<dim2
				ret.dimnames=options.like.dimnames(1);
			end
		else
			ret=typecast(gather(self),dstar{options});
		end
	end
end