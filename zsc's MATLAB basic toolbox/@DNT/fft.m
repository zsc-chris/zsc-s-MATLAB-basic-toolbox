function ret=fft(self,n)
%FFT	Discrete Fourier transform of dnm
%	ret=FFT(self,n/(n,dims)/*n/**n/mapping(**n))
%
%	Note: To avoid ambiguity, n will not be broadcast if it is scalar.
%
%	Example:
%	>> FFT(DNT([1,2;4,2;9,0],["a","b"]),a=2)
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b          1     2
%	    a
%
%	    1               5     4
%	    2              -3     0
%
%	>> FFT(DNT([1,2;4,2;9,0],["a","b"]),2,"a")
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	         b          1     2
%	    a
%
%	    1               5     4
%	    2              -3     0
%
%	See also fft, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Input,Repeating)
		n(1,:)
	end
	arguments(Output)
		ret DNT
	end
	n=paddata(n,1,FillValue={self.dimnames});
	if isscalar(n)
		if ischar(n{1})||iscellstr(n{1})||isstring(n{1})
			n=num2cell(string(n{1}));
			n(2,:)=num2cell(size(self,zsc.cell2mat(n)));
			n=n(:);
		end
	end
	n=parsedimargs(self.dimnames,n);
	zsc.assert(isempty(n)||isequaln(sort(zsc.cell2mat(n(1,:))),unique(zsc.cell2mat(n(1,:)))),"ZSC:DNT:repeatedDimensions","Repeated dimensions not allowed.")
	ret=fevalalong(@fft_,zsc.cell2mat(n(1,:)),self,KeepDims=true,AdditionalInput={zsc.cell2mat(n(2,:))});
end
function self=fft_(self,dims,n)
	for i=1:numel(dims)
		self=fft(self,n(i),dims(i));
	end
end
