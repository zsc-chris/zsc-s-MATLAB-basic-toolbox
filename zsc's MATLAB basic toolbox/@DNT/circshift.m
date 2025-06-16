function ret=circshift(self,K)
%CIRCSHIFT	Shift positions of elements circularly for DNT
%	ret=CIRCSHIFT(self,K/(K,dims)/*K/**K/mapping(**K))
%
%	Example:
%	>> CIRCSHIFT(DNT([1,2;3,4],["a","b"]),a=1)
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              3    4
%	    2              1    2
%
%	>> CIRCSHIFT(DNT([1,2;3,4],["a","b"]),1,"a")
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b         1    2
%	    a
%
%	    1              3    4
%	    2              1    2
%
%	See also circshift, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Input,Repeating)
		K(1,:)
	end
	arguments(Output)
		ret DNT
	end
	zsc.assert(~isempty(K),message("MATLAB:minrhs"))
	K=parsedimargs(self.dimnames,K);
	zsc.assert(isempty(K)||isequaln(sort(zsc.cell2mat(K(1,:))),unique(zsc.cell2mat(K(1,:)))),"ZSC:DNT:repeatedDimensions","Repeated dimensions not allowed.")
	ret=fevalalong(@circshift_,zsc.cell2mat(K(1,:)),self,KeepDims=true,AdditionalInput=zsc.cell2mat(K(2,:),[],false));
end
function self=circshift_(self,dims,K)
	for i=1:numel(dims)
		self=circshift(self,K(i),dims(i));
	end
end