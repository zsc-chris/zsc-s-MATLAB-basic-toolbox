function [ret,q]=iqr(self,dims)
%IQR	Interquartile range of data set
%	[ret,q]=IQR(self,dims=self.dimnames) reduces self along dims by @IQR.
%
%	Note: A new dimension will be selected if dims is empty.
%
%	Example:
%	>> IQR(DNT([1,2;3,4],["a","b"]),"a")
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    b
%
%	    1              2
%	    2              2
%
%	>> IQR(DNT([1,2;3,4],["a","b"]),"b")
%
%	ans =
%
%	  2 DNT double vector
%
%
%	    a
%
%	    1              1
%	    2              1
%
%	>> IQR(DNT([1,2;3,4],["a","b"]),["a","b"])
%
%	ans =
%
%	  DNT double scalar
%
%	     2
%
%	>> IQR(DNT([1,2;3,4],["a","b"]),[])
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
%	See also iqr, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		dims(1,:){mustBeA(dims,["logical","numeric","string","char","cell","missing"])}=self.dimnames
	end
	[ret,q]=fevalalong(@iqr,dims,self,Mode="flatten",KeepDims=[false,true]);
end