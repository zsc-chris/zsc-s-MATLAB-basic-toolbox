function C=num2cell(A,dim)
%zsc.num2cell	Improved version of MATLAB num2cell
%	C=zsc.num2cell(A,dim) cut A into cell preserving the dim dimensions.
%	A special case where dim=[] is considered.
%
%	See also num2cell

%	Copyright 2024 Chris H. Zhao
	arguments
		A
		dim(:,1)double{mustBeInteger,mustBePositive}=[]
	end
	if isempty(dim)
		C=num2cell(A);
	else
		C=num2cell(A,dim');
	end
end