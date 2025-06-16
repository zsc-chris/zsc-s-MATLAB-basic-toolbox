function ret=cumprod(self,dims,direction,nanflag)
%CUMPROD	Cumulative product of elements of DNT
%	ret=CUMPROD(self,dims=self.dimnames,direction="forward",
%	nanflag="includemissing") transforms self along dims by @CUMPROD.
%
%	See also cumprod, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		direction(1,1)string{mustBeMember(direction,["forward","reverse"])}="forward"
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitmissing","omitnan"])}="includemissing"
	end
	arguments(Output)
		ret DNT
	end
	ret=fevalalong(@cumprod,dims,self,Mode="iterate",KeepDims=true,AdditionalInput={direction,nanflag});
end