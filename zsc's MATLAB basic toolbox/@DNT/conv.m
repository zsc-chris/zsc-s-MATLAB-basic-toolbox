function ret=conv(self,other,dims,shape,options)
%CONV	Convolution for certain dimensions only
%	ret=CONV(self,other,dims=self.dimnames,shape="full",*,Precise=false)
%	FFT convolution is used if Precise==false.
%
%	See also conv

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		shape(1,1)string{mustBeMember(shape,["full","same","valid"])}="full"
		options.Precise(1,1)logical=false
	end
	arguments(Output)
		ret DNT
	end
	constructor=str2func(class(self));
	if options.Precise
		ret=fevalalong(@convn,dims,self,other,keepdim=true,AdditionalInput={shape},BroadcastSizeDims="other",Vectorized=false);
	else
		[self,other]=fevalalong(@deal,dims,self,other,KeepDims=true,BroadcastSizeDims="other",Vectorized=false);
		dims=parsedims(self.dimnames,dims);
		sz1=size(self,dims);
		sz2=size(other,dims);
		ret=ifft(fft(self,sz1+sz2-1,dims).*fft(other,sz1+sz2-1,dims),sz1+sz2-1,dims);
		switch shape
			case "same"
				ret=subsref(ret,substruct("()",{dictionary(dims,arrayfun(@(dim,sz1,sz2){constructor((round((sz2-1)/2)+1:round((2*sz1+sz2-1)/2))',dim)},dims,sz1,sz2))}));
			case "valid"
				ret=subsref(ret,substruct("()",{dictionary(dims,arrayfun(@(dim,sz1,sz2){constructor((min(sz1,sz2):max(sz1,sz2))',dim)},dims,sz1,sz2))}));
		end
	end
end