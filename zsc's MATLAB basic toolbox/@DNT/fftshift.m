function ret=fftshift(self,dims)
%FFTSHIFT	Shift zero-frequency component to center of spectrum
%	ret=FFTSHIFT(self,dims=self.dimnames) transforms self along dims by
%	@FFTSHIFT.
%
%	See also fftshift, DNT

%	Copyright 2025 Chris H. Zhao
	arguments
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing","missing"])}=1:ndims(self)
	end
	ret=fevalalong(@fftshift,dims,self,Mode="iterate",KeepDims=true);
end