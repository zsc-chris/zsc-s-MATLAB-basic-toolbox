function ret=superiorfloat(varargin)
%SUPERIORFLOAT	Return 'double' or 'single' based on the superior input
%	ret=SUPERIORFLOAT(*varargin)
%
%	See also superiorfloat, DNT

%	Copyright 2024–2025 Chris H. Zhao
	arguments(Input,Repeating)
		varargin
	end
	arguments(Output)
		ret(1,:)char
	end
	varargin=cellfun(@(x)ifinline(isa(x,"DNT"),@()gather(x),@()x),varargin,UniformOutput=false);
	ret=superiorfloat(varargin{:});
end