function ret=nonzeros(self,n,dims,direction)
%NONZEROS	Nonzero DNT elements
%	ret=NONZEROS(self,n=[],dims=self.dimnames,direction="first") transforms
%	self along dims by @FIND and takes the second output.
%
%	Note: Outputs are padded to the longest (not necessarily n) with NaN.
%	Note: A new dimension will be selected if dims is empty.
%
%	Example:
%	>> NONZEROS(DNT([1,0;3,4],["a","b"]),[],"a")
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b           1      2
%	    a
%
%	    1                1      4
%	    2                3    NaN
%
%	>> NONZEROS(DNT([1,0;3,4],["a","b"]),[],"b")
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b           1      2
%	    a
%
%	    1                1    NaN
%	    2                3      4
%
%	>> NONZEROS(DNT([1,0;3,4],["a","b"]),[],["a","b"])
%
%	ans =
%
%	  3 DNT double vector
%
%
%	    a×b
%
%	      1                  1
%	      2                  3
%	      3                  4
%
%	>> NONZEROS(DNT([1,0;3,4],["a","b"]),[],[])
%
%	  2×2×1 DNT double tensor
%
%	ans(a=':',b=':',x''=1).squeeze(3) =
%
%	         b           1      2
%	    a
%
%	    1                1    NaN
%	    2                3      4
%
%	>> NONZEROS(DNT([1,0;3,4],["a","b"]),[],"c")
%
%	  2×2×1 DNT double tensor
%
%	ans(a=':',b=':',c=1).squeeze(3) =
%
%	         b           1      2
%	    a
%
%	    1                1    NaN
%	    2                3      4
%
%	See also nonzeros, find, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		n double{mustBeTrue("@(n)isequal(n,[])||n>=0&&succeeds(@()mustBeInteger(n))",n,VariableNames="n")}=[]
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		direction(1,1)string{mustBeMember(direction,["first","last"])}="first"
	end
	arguments(Output)
		ret DNT
	end
	dstar=dstarclass;
	[~,ret]=find(self,n,dims,direction);
end