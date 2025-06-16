function [ret,BG,BP]=groupcounts(self,options)
%GROUPCOUNTS	Counts by group
%	[ret,BG,BP]=GROUPCOUNTS(self,*,IncludeMissingGroups=true,
%	IncludeEmptyGroups=false) counts by group defined by self along its
%	dimension.
%
%	Note: Groupbins and options related to it are not supported. Use
%		findgroups and discretize first.
%	Note: Do not use string as dtype for groupvars. Otherwise it may
%		interfere with chaotic evil arguments system of MATLAB.
%
%	Example:
%	>> [ret,BG,BP]=groupcounts(DNT([2;3;2;3;4;5;4],"a"))
%
%	ret =
%
%	  4 DNT double vector
%
%
%	    a
%
%	    1              2
%	    2              2
%	    3              2
%	    4              1
%
%
%	BG =
%
%	  4 DNT double vector
%
%
%	    a
%
%	    1              2
%	    2              3
%	    3              4
%	    4              5
%
%
%	BP =
%
%	  4 DNT double vector
%
%                          
%	    a                     
%
%	    1              28.5714
%	    2              28.5714
%	    3              28.5714
%	    4              14.2857
%
%	See also groupcounts, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		options.IncludeMissingGroups(1,1)logical=true
		options.IncludeEmptyGroups(1,1)logical=false
	end
	arguments(Output)
		ret DNT
		BG DNT
		BP DNT
	end
	self=flatten(self);
	[ret,BG,BP]=feval(@groupcounts,self);
end