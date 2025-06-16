function ret=gpuArray(self)
%gpuArray	Convert DNT to gpuArray
%	ret=gpuArray(self)
%
%	See also gpuArray

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
	end
	arguments(Output)
		ret DNT
	end
	ret=feval(@gpuArray,self);
end