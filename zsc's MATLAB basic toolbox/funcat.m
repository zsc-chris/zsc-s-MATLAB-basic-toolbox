function ret=funcat(fs)
%FUNCAT	Concatenate function output
%	"FUNCAT(*fs)(*args)=*[f(*args) for f in fs]" where fs is a vector of
%	single-output functions.
%
%	Example:
%	>> f=FUNCAT(@sin,@cos)
%
%	f =
%
%	  function_handle with value:
%
%	    @funcat/f
%
%	   	nargin: 1
%	  	nargout: 2
%
%	>> [a,b]=f(1)
%
%	a =
%
%	    0.8415
%
%
%	b =
%
%	    0.5403
%
%	See also deal

%	Copyright 2023–2025 Chris H. Zhao
	arguments(Input,Repeating)
		fs(1,1)function_handle;
	end
	function varargout=f(varargin)
		varargout=cell(1,numel(fs));
		for i=1:numel(fs)
			varargout{i}=fs{i}(varargin{:});
		end
	end
	ret=zsc.function_handle(@f,paddata(min(feval(@(x)x(x>=0),cellfun(@nargin,fs))),1,FillValue=-1),numel(fs));
end