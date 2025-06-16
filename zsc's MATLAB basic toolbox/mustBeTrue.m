function mustBeTrue(condstr,args,options)
%mustBeTrue	Validate that condition is true
%	mustBeTrue(condstr,*args,VariableNames=cellfun(@string,
%	arrayfun(str2func("inputname"),2:numel(args)+1,UniformOutput=false)))
%	passes args to str2func(condstr) and asserts the result is true.
%	VariableNames is used for error message. Can do any validation
%	theoretically.
%
%	Note: mustBeTrue cannot access private method. If one wants to do so,
%	the string arguments can be changed to function by defining an alias
%	for eval to convert string into function handle.
%
%	Example:
%	>> mustBeTrue("@(a,b)a==b",1,1,VariableNames=["a","options.b"])
%	>> mustBeTrue("@(a,b)a==b",1,2,VariableNames=["a","options.b"])
%	Error using mustBeTrue (line 35)
%	Argument(s) "a", "options.b" failed to meet the
%	condition defined by "@(a,b)a==b".
%
%	See also arguments

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		condstr(1,1)string
	end
	arguments(Input,Repeating)
		args
	end
	arguments(Input)
		options.VariableNames(1,:)string=cellfun(@string,arrayfun(str2func("inputname"),2:numel(args)+1,UniformOutput=false))
	end
	cond=str2func(condstr);
	try
		zsc.assert(cond(args{:}),"MATLAB:validators:mustBeTrue","Argument(s) "+join(""""+options.VariableNames+"""",", ")+" failed to meet the condition defined by """+func2str(cond)+""".");
	catch ME
		rethrowAsCaller(ME)
	end
end