function ret=mad(self,flag,dims)
%MAD	Mean/median absolute deviation (×) I am mad (√)
%	ret=MAD(self,flag=0,dims=self.dimnames) reduces self along dims by
%	"mean if flag==0 else median" absolute deviation.
%
%	Example:
%	>> MAD(DNT([1,2;3,4],["a","b"]),0,"a")
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              1
%	    2              1
%
%	>> MAD(DNT([1,2;3,4],["a","b"]),0,"b")
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    a
%
%	    1              0.5000
%	    2              0.5000
%
%	>> MAD(DNT([1,2;3,4],["a","b"]),0,["a","b"])
%
%	ans =
%
%	  DNT double scalar
%
%	     1
%
%	>> MAD(DNT([1,2;3,4],["a","b"]),0,[])
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              0    0
%	    2              0    0
%
%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		flag(1,1)double{mustBeMember(flag,[0,1])}=0
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
	end
	if flag
    	ret=nanmedian(abs(self-nanmedian(self,dims)),dims);
	else
    	ret=nanmean(abs(self-nanmean(self,dims)),dims);
	end
end