function S=str2subs(str)
%str2subs	Convert string to substruct
%	S=str2subs(str) converts str to substruct, evaluating in caller
%	workspace.
%
%	Example:
%	>>> a="a";
%	>>> str2subs("(a).(a){a}(a)")
%
%	ans =
%
%	  1×4 struct array with fields:
%
%	    type
%	    subs
%
%	See also substruct

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		str(1,1)string{mustBeTrue("@(str)str==""""||regexp(str,""^[\.\(\{]"")",str,VariableNames="str")}
	end
	arguments(Output)
		S(1,:)struct
	end
	if str==""
		S=struct(type=cell(1,0),subs=cell(1,0));
	else
		varname=join([string(evalin("caller","who"));"a"],"");
		evalin("caller",varname+"=getsubsclass;")
		try
			S=evalin("caller",varname+str);
		catch ME
		end
		evalin("caller","clear "+varname)
		if exist("ME","var")
			rethrow(ME)
		end
	end
end