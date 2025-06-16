function B=subsref(self,S)
%SUBSREF	Subscripted reference
%	*B=SUBSREF(self,S)
%
%	See also subsref, dstarclass

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self dstarclass
		S(:,1)struct
	end
	arguments(Output,Repeating)
		B
	end
	if S(1).type=="."
		[B{1:nargout}]=builtin("subsref",self,S);
	else
		mapping=S(1).subs{1};
		if isa(mapping,"table")
			if size(mapping,2)==2&&(isstring(mapping{:,1})||iscellstr(mapping{:,1}))
				B=[num2cell(string(mapping{:,1})),num2cell(mapping{:,2},2)]';
			else
				B=reshape(namedargs2cell(zsc.table2struct(mapping,ToScalar=true)),2,[]);
				B(1,:)=cellfun(@string,B(1,:),UniformOutput=false);
			end
		elseif isa(mapping,"dictionary")
			mapping=mapping.entries;
			B=[num2cell(string(mapping{:,1})),num2cell(mapping{:,2},2)]';
		elseif isa(mapping,"struct")
			B=reshape(namedargs2cell(mapping),2,[]);
			B(1,:)=cellfun(@string,B(1,:),UniformOutput=false);
		end
		B(2,:)=cellfun(@(x)zsc.subsref(x,S(2:end)),B(2,:),UniformOutput=false);
		if S(1).type=="()"
			B={B};
		end
	end
end