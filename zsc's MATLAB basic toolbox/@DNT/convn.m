function ret=convn(self,other,shape,options)
%CONVN	N-dimensional convolution of DNTs
%	ret=CONVN(self,other,shape="full",*,Precise=false)
%	FFT convolution is used if Precise==false.
%
%	See also convn

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self
		other
		shape(1,1)string{mustBeMember(shape,["full","same","valid"])}="full"
		options.Precise(1,1)logical=false
	end
	arguments(Output)
		ret DNT
	end
	if options.Precise
		ret=feval(@convn,self,other,AdditionalInput={shape},BroadcastSize=false);
	else
		ret=feval(@fftconvn,self,other,AdditionalInput={shape},BroadcastSize=false);
	end
end