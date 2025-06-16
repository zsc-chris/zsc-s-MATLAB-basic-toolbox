function ret=ifftshift(self,dims)
%IFFTSHIFT	Inverse FFT shift
%	ret=IFFTSHIFT(self,dims=self.dimnames) transforms self along dims by
%	@IFFTSHIFT.
%
%	See also ifftshift, DNT

%	Copyright 2025 Chris H. Zhao
	arguments
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing","missing"])}=1:ndims(self)
	end
	ret=fevalalong(@ifftshift,dims,self,Mode="iterate",KeepDims=true);
end