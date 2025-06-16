function B=ipermute(A,dimorder)
%zsc.ipermute	Improved version of MATLAB IPERMUTE
%	B=zsc.ipermute(A,dimorder=[]) supports numel(dimorder)<2.
%
%	See also ipermute, zsc.permute

%	Copyright 2025 Chris H. Zhao
	arguments
		A
		dimorder(1,:)double=[]
	end
	try
		B=ipermute(A,[dimorder,numel(dimorder)+1:2]);
	catch ME
		if isscalar(A)
			B=A;
		elseif isempty(A)
			empty=str2func(class(A)+".empty");
			inverseorder(dimorder)=1:numel(dimorder);
			B=empty(size(A,[inverseorder,numel(inverseorder)+1:2]));
		else
			rethrow(ME)
		end
	end
end