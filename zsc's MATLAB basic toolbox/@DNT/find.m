function [ret,v]=find(self,n,dims,direction)
%FIND	Find indices of nonzero elements of DNT
%	[ret,v]=FIND(self,n=[],dims=self.dimnames,direction="first")
%	transforms self along dims by @FIND.
%
%	Note: Outputs are padded to the longest (not necessarily n) with NaN.
%	Note: A new dimension will be selected if dims is empty.
%
%	Example:
%	>> FIND(DNT([1,0;3,4],["a","b"]),[],"a")
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b           1      2
%	    a
%
%	    1                1      2
%	    2                2    NaN
%
%	>> FIND(DNT([1,0;3,4],["a","b"]),[],"b")
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b           1      2
%	    a
%
%	    1                1    NaN
%	    2                1      2
%
%	>> FIND(DNT([1,0;3,4],["a","b"]),[],["a","b"])
%
%	ans =
%
%	  3 DNT double vector
%
%
%	    a×b
%
%	      1                  1
%	      2                  2
%	      3                  4
%
%	>> FIND(DNT([1,0;3,4],["a","b"]),[],[])
%
%	  2×2×1 DNT double tensor
%
%	ans(a=':',b=':',x''=1).squeeze(3) =
%
%	         b           1      2
%	    a
%
%	    1                1    NaN
%	    2                1      1
%
%	>> FIND(DNT([1,0;3,4],["a","b"]),[],"c")
%
%	  2×2×1 DNT double tensor
%
%	ans(a=':',b=':',c=1).squeeze(3) =
%
%	         b           1      2
%	    a
%
%	    1                1    NaN
%	    2                1      1
%
%	See also find, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		n double{mustBeTrue("@(n)isequal(n,[])||n>=0&&succeeds(@()mustBeInteger(n))",n,VariableNames="n")}=[]
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
		direction(1,1)string{mustBeMember(direction,["first","last"])}="first"
	end
	arguments(Output)
		ret DNT
		v DNT
	end
	if isequal(n,0)
		ret=fevalalong(@(self)repmat(self,[0,1]),dims,self,Mode="flatten",KeepDims=true,Vectorized=false);
		v=ret;
	else
		[ret,~,v]=fevalalong(@find,dims,self,Mode="flatten",KeepDims=true,AdditionalInput=ifinline(isequal(n,[]),@(){},@(){n,direction}),Vectorized=false);
	end
end