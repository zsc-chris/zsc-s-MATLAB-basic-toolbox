function varargout=gather(varargin)
%GATHER	Get the value of DNT (i.e. strip the DNT adapter layer)
%	*varargout=GATHER(*varargin) applies @GATHER to varargin, where gather
%	on DNT is to get its value.
%
%	Note: If one wants to gather tall/codistributed/distributed/gpuArray
%	array inside the DNT, use feval(@GATHER,...).
%
%	See also gather, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input,Repeating)
		varargin
	end
	arguments(Output,Repeating)
		varargout
	end
	varargout=cellfun(@(x)ifinline(isa(x,"DNT"),@()x.data,@()gather(x)),varargin,UniformOutput=false);
end