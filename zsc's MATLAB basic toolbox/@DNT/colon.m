function ret=colon(varargin)
%:	Colon
%	ret=j:k
%	ret=j:i:k
%	ret=COLON(j,k)
%	ret=COLON(j,i,k)
%	DNT/COLON check if j, i, k is scalar and gather all DNT inputs, so ret
%	is not DNT.
%
%	Example:
%	>> DNT(1):gpuArray(2):DNT(5)
%
%	ans =
%
%	     1     3     5
%
%	class(ans)
%
%	ans =
%
%	    'gpuArray'
%
%	See also colon, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input,Repeating)
		varargin(1,1)
	end
	arguments(Output)
		ret(1,:)
	end
	zsc.assert(nargin>1,message("MATLAB:minrhs"))
	zsc.assert(nargin<4,message("MATLAB:maxrhs"))
	varargin=cellfun(@(x)ifinline(isa(x,"DNT"),@()gather(x),@()x),varargin,UniformOutput=false);
	ret=colon(varargin{:});
end