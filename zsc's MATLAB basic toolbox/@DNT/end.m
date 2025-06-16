function ret=end(self,k,n)
%END	Overloaded for DNT
%	ret=END(self,k,n)
%
%	See also end, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		k(1,1)double{mustBeInteger,mustBePositive}
		n(1,1)double{mustBeInteger,mustBePositive}
	end
	arguments(Output)
		ret double{mustBeInteger,mustBeNonnegative}
	end
	if k<n
		ret=size(self,k);
	else
		ret=prod(size(self,k:ndims(self)));
	end
end