function B=permute(A,dimorder)
%zsc.permute	Improved version of MATLAB PERMUTE
%	B=zsc.permute(A,dimorder=[]) supports numel(dimorder)<2.
%
%	See also permute, zsc.ipermute

%	Copyright 2025 Chris H. Zhao
	arguments
		A
		dimorder(1,:)double=[]
	end
	try
		B=permute(A,[dimorder,numel(dimorder)+1:2]);
	catch ME
		if isscalar(A)
			B=A;
		elseif isempty(A)
			empty=str2func(class(A)+".empty");
			B=empty(size(A,[dimorder,numel(dimorder)+1:2]));
		else
			rethrow(ME)
		end
	end
end