function rethrowAsCaller(exception)
%rethrowAsCaller	Rethrow as caller, hiding current layer
%	rethrowAsCaller(exception) throws MException exception after removing
%	all elements in stack that represents current layer. This solves the
%	problem of stack after this layer is lost using throwAsCaller.
%
%	Example:
%	>> % Note the difference
%	>> feval(@()eval("try;sin;catch ans;rethrowAsCaller(ans);end"))
%	Error using eval
%	Not enough input arguments.
%
%	>> feval(@()eval("try;sin;catch ans;rethrow(ans);end"))
%	Error using eval
%	Not enough input arguments.
%
%	Error in @()eval("try;sin;catch ans;rethrow(ans);end")
%
%	See also throwAsCaller, MException, error

%	Copyright 2025 Chris H. Zhao
	arguments
		exception(1,1)MException
	end
	state=warning("off","MATLAB:structOnObject");
	cleanerup=onCleanup(@()warning(state));
	try
		zsc.assert(struct(exception).hasBeenCaught,"MATLAB:MException:rethrowAsCaller:uncaughtException","")
	catch ME
		if ME.identifier=="MATLAB:MException:rethrowAsCaller:uncaughtException"
			stack=ME.stack;
			stack(1).line=0;
			error(struct(message="RETHROWASCALLER can only throw a previously caught exception.",identifier="MATLAB:MException:rethrowAsCaller:uncaughtException",stack=stack))
		end
	end
	try
		throwAsCaller(MException("a:a","a"))
	catch ME
		type=struct(exception).type;
		stack=ifinline(isequal(type{2},''),@()exception.stack,@()[struct(file='',name=type{2},line=0);exception.stack]);
		if ~isempty(ME.stack)
			last=ME.stack(1);
			stack(string({stack.file})==string(last.file)&string({stack.name})==string(last.name),:)=[];
		end
		error(struct(message=exception.message,identifer=exception.identifier,stack=stack))
	end
end