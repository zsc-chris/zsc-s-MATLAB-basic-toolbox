function sz=size(self,dims)
%SIZE	Size of DNT
%	sz/*sz=SIZE(self,dims/*dims)
%
%	See also size, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Input,Repeating)
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}
	end
	arguments(Output,Repeating)
		sz(1,:)double{mustBeInteger,mustBeNonnegative}
	end
	if isequal(dims,cell.empty(1,0))
		dims={1:ndims(self)};
	end
	dims=zsc.cell2mat(dims);
	dims=parsedims(self.dimnames,dims);
	dims=DNT.index(self.dimnames,dims);
	[sz{1:nargout}]=size(gather(self),dims);
end