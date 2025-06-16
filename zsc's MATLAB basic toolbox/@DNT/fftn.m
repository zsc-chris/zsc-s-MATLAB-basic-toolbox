function ret=fftn(self,sz)
%FFTN	N-dimensional discrete Fourier Transform
%	ret=FFTN(self,sz=size(self))
%
%	See also fftn, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		sz(1,:)double{mustBeInteger,mustBeNonnegative}=size(self)
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@fftn,self,AdditionalInput={paddata(sz,2,FillValue=1)});
end