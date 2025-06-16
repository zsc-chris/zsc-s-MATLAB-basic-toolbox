function ret=del2(self,h)
%del2	Discrete Laplacian
%	ret=del2(self,*h/**h/mapping(**h))
%
%	Note: zsc.del2 is called for this function.
%	Note: To avoid ambiguity, h will not be broadcast if it is scalar.
%	Note: To avoid ambiguity, ExtrapolationMethod is not supported.
%
%	Example:
%	>> del2(DNT([1,2;4,2;9,0],["a","b"]),a=2)
%
%	ans =
%
%	  3×2 DNT double matrix
%
%	         b               1          2
%	    a
%
%	    1               0.5000    -0.5000
%	    2               0.5000    -0.5000
%	    3               0.5000    -0.5000
%
%	>> del2(DNT([1,2;4,2;9,0],["a","b"]),2,"a")
%
%	ans =
%
%	  3×2 DNT double matrix
%
%	         b               1          2
%	    a
%
%	    1               0.5000    -0.5000
%	    2               0.5000    -0.5000
%	    3               0.5000    -0.5000
%
%	See also zsc.del2, del2, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Input,Repeating)
		h(1,:)
	end
	arguments(Output)
		ret DNT
	end
	h=paddata(h,1,fillvalue={1});
	if isscalar(h)
		if ischar(h{1})||iscellstr(h{1})||isstring(h{1})
			h=num2cell(string(h{1}));
			h(2,:)={1};
			h=h(:);
		end
	end
	h=parsedimargs(self.dimnames,h,false);
	zsc.assert(isempty(h)||isequaln(sort(zsc.cell2mat(h(1,:))),unique(zsc.cell2mat(h(1,:)))),"ZSC:DNT:repeatedDimensions","Repeated dimensions not allowed.")
	ret=fevalalong(@zsc.del2,zsc.cell2mat(h(1,:)),self,KeepDims=true,Vectorized=false,AdditionalInput=h(2,:));
end