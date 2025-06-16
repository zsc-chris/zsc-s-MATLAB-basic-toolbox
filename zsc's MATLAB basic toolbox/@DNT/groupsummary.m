function [DNTs,BG,BC]=groupsummary(DNTs,groupvars,method,options)
%GROUPSUMMARY	Summary computations by group
%	[DNTs,BG,BC]=GROUPSUMMARY(DNTs,groupvars,method,*,
%	IncludeMissingGroups=true,IncludeEmptyGroups=false) reduces DNTs by
%	group defined by groupvars along its dimension using method.
%	DNTs                 - {*DNTs}
%	groupvars            - DNT
%		Will be broadcast against DNTs along groupvars.dimnames.
%	method               - function_handle scalar
%		Inputs to method are DNTs containing a flattened dimension named
%		flatten(groupvars.dimnames) along with other dimensions untouched.
%		method should reduce the flattened dimension (no need to squeeze
%		though), whether other dimensions are affected or not.
%		nargout(method) must be specified via zsc.function_handle/funcat.
%	IncludeMissingGroups - logical scalar
%	IncludeEmptyGroups   - logical scalar
%
%	Note: Groupbins and options related to it, as well as non-scalar
%		groupvars, are not supported. Use findgroups and discretize first.
%	Note: Do not use string as dtype for groupvars. Otherwise it may
%		interfere with chaotic evil arguments system of MATLAB.
%
%	Example:
%	>> [DNTs,BG,BC]=groupsummary({DNT([1,2;3,4;5,6],["a","b"]),DNT([1,2;5,6;3,4],["a","b"])},DNT(1,"a"),funcat(@(x,y)sum(x,"a")+sum(y,"a"),@(x,y)prod(x)+prod(y)))
%
%	DNTs =
%
%	  1×2 cell array
%
%	    {1×2 DNT}    {1 DNT}
%
%
%	BG =
%
%	  1 DNT double vector
%
%
%	    a
%
%	    1              1
%
%
%	BC =
%
%	  1 DNT double vector
%
%
%	    a
%
%	    1              3
%
%	>> DNTs{:}
%
%	ans =
%
%	  1×2 DNT double matrix
%
%	         b          1     2
%	    a
%
%	    1              18    24
%
%
%	ans =
%
%	  1 DNT double vector
%
%
%	    a
%
%	    1              1440
%
%	See also groupsummary, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		DNTs(1,:)cell
		groupvars DNT
		method(1,1)function_handle
		options.IncludeMissingGroups(1,1)logical=true
		options.IncludeEmptyGroups(1,1)logical=false
	end
	arguments(Output)
		DNTs(1,:)cell
		BG DNT
		BC DNT
	end
	constructor=str2func(class(groupvars));
	if isscalar(groupvars)
		groupvars=constructor(groupvars,DNT.gennewdims(numel(unique(zsc.cell2mat(cellfun(@(x)x.dimnames,DNTs,UniformOutput=false))))+1));
	end
	star=starclass;
	[tmp{1:numel(DNTs)+1}]=feval(@deal,star{cellfun(@(DNT)subsasgn(DNT,substruct(".","dimnames","()",{~ismember(DNT.dimnames,groupvars.dimnames)}),missing),[DNTs,{groupvars}],UniformOutput=false),2}{:});
	tmp=tmp{1};
	out=outclass;
	[DNTs{:},groupvars]=star{cellfun(@(DNT)out{2,1,@(varargin)feval(@deal,varargin{:}),DNT,tmp},[DNTs,{groupvars}],UniformOutput=false),2}{:};
	clear tmp
	dims=groupvars.dimnames;
	DNTs=cellfun(@(x)flatten(x,dims),DNTs,UniformOutput=false);
	dim=DNT.catdims(dims);
	DNTs=cellfun(@(x)flatten(gather(num2cell(x,setdiff(x.dimnames,dim)))),DNTs,UniformOutput=false);
	groupvars=flatten(groupvars);
	DNTs=num2cell([DNTs{:}],2);
	function DNTs=method_(DNTs)
		DNTs=cellfun(@(x)cat(dim,x{:}),num2cell(zsc.cell2mat(DNTs),1),UniformOutput=false);
		[tmp{1:nargout(method)}]=method(DNTs{:});
		DNTs=tmp;
		DNTs=cellfun(@(x)flatten(gather(num2cell(x,setdiff(x.dimnames,dim)))),DNTs,UniformOutput=false);
		DNTs=num2cell([DNTs{:}],2);
	end
	dstar=dstarclass;
	[DNTs,BG,BC]=groupsummary({DNTs},gather(groupvars),@method_,dstar{options});
	DNTs=cellfun(@(x)cat(dim,x{:}),num2cell(zsc.cell2mat(DNTs),1),UniformOutput=false);
	BG=constructor(BG,DNT.catdims(dims));
	BC=constructor(BC,DNT.catdims(dims));
end