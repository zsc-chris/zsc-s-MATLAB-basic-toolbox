function ret=cummin(self,dims,direction,nanflag)
%CUMMIN	Cumulative minimum of elements of DNT
%	ret=CUMMIN(self,dims=self.dimnames,direction="forward",
%	nanflag="includemissing") transforms self along dims by @CUMMIN.
%
%	See also cummin, DNT

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
	ret=fevalalong(@cummin,dims,self,Mode="iterate",keepdim=true,AdditionalInput={direction,nanflag});
end