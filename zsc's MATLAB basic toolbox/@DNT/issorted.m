function ret=issorted(self,dims,direction,options)
%ISSORTED	Check if DNT data is sorted
%	ret=issorted(self,dims=self.dimnames,direction="ascend",*,
%	MissingPlacement="auto",ComparisonMethod="auto") check if self is
%	sorted along dims.
%
%	Example:
%	>> ISSORTED(DNT([1,2;3,4],["a","b"]),["a","b"])
%
%	ans =
%
%	  logical
%
%	   0
%
%	>> issorted(DNT([1,3;2,4],["a","b"]),["a","b"])
%
%	ans =
%
%	  logical
%
%	   1
%
%	See also issorted, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		direction(1,1)string{mustBeMember(direction,["ascend","descend","monotonic","strictascend","strictdescend","strictmonotonic"])}="ascend"
		options.MissingPlacement(1,1)string{mustBeMember(options.MissingPlacement,["auto","first","last"])}="auto"
		options.ComparisonMethod(1,1)string{mustBeMember(options.ComparisonMethod,["auto","real","abs"])}="auto"
	end
	arguments(Output)
		ret(1,1)logical
	end
	dstar=dstarclass;
	ret=gather(fevalalong(@issorted,dims,self,Mode="flatten",AdditionalInput={direction,dstar{options}}));
end