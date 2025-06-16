function ret=cummax(self,dims,direction,nanflag)
%CUMMAX	Cumulative maximum of elements of DNT
%	ret=CUMMAX(self,dims=self.dimnames,direction="forward",
%	nanflag="includemissing") transforms self along dims by @CUMMAX.
%
%	See also cummax, DNT

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
	ret=fevalalong(@cummax,dims,self,Mode="iterate",KeepDims=true,AdditionalInput={direction,nanflag});
end