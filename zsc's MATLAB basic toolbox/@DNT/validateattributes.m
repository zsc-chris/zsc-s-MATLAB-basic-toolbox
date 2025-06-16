function validateattributes(self,varargin)
%VALIDATEATTRIBUTES	Validate attributes of a DNT
%	VALIDATEATTRIBUTES(self,*varargin) tries to validate self, and then
%	gather(self), and finally errors.
%
%	See also validateattributes, DNT

%	Copyright 2025 Chris H. Zhao
	try
		try
			builtin("validateattributes",self,varargin{:})
		catch
			builtin("validateattributes",gather(self),varargin{:})
		end
	catch ME
		rethrowAsCaller(ME)
	end
end