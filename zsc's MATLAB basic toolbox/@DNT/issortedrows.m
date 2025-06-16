function ret=issortedrows(self,dim,column,direction,options)
%ISSORTEDROWS	Determine whether array is sorted by rows
%	ret=ISSORTEDROWS(self,dim=1,column=1,direction="ascend",*,
%	MissingPlacement="auto",ComparisonMethod="auto") check if self is
%	sorted along dim by row according to column as precedence.
%
%	>> ISSORTEDROWS(DNT([3,1;4,2],["a","b"]),"a")
%
%	ans =
%
%	  logical
%
%	   1
%
%	>> ISSORTEDROWS(DNT([3,1;4,2],["a","b"]),"b")
%
%	ans =
%
%	  logical
%
%	   0
%
%	See also issortedrows, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dim(1,:){mustBeA(dim,["logical","numeric","string","char","cell","missing"])}=1
		column(1,:)double=1
		direction(1,:)string{mustBeMember(direction,["ascend","descend"])}="ascend"
		options.MissingPlacement(1,1)string{mustBeMember(options.MissingPlacement,["auto","first","last"])}="auto"
		options.ComparisonMethod(1,1)string{mustBeMember(options.ComparisonMethod,["auto","real","abs"])}="auto"
	end
	arguments(Output)
		ret(1,1)logical
	end
	dstar=dstarclass;
	dim=parsedims(self.dimnames,dim);
	zsc.assert(isscalar(dim),"ZSC:DNT:multipleDimensions","One and only one dimension must be specified.")
	ret=gather(fevalalong(@issortedrows,dim,self,Mode="flattenall",AdditionalInput={column,direction,dstar{options}}));
end