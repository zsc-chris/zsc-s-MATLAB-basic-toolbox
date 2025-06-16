function y=feval(fun,x,options)
%FEVAL	Improved version of MATLAB FEVAL
%	*y=FEVAL(fun,*x,AdditionalInput={},BroadcastSize=true) broadcasts *x
%	against each other if BroadcastSize==true, and apply fun.
%	*AdditionalInput are not broadcast. Set fun to @deal to manually
%	broadcast arrays.
%
%	Example:
%	>> zsc.feval(@plus,[1,2],[3;4])
%
%	ans =
%
%	     4     5
%	     5     6
%
%	>> zsc.feval(@(x,y)arrayfun(@plus,x,y),[1,2],[3;4])
%
%	ans =
%
%	     4     5
%	     5     6
%
%	>> out=outclass;
%	>> out{2,1:2,@zsc.feval,@deal,[1,2],[3;4]}
%
%	ans =
%
%	     1     2
%	     1     2
%
%
%	ans =
%
%	     3     3
%	     4     4
%
%	See also feval

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		fun(1,1)function_handle
	end
	arguments(Input,Repeating)
		x
	end
	arguments(Input)
		options.AdditionalInput(1,:)cell={}
		options.BroadcastSize(1,1)logical=true
	end
	arguments(Output,Repeating)
		y
	end
	maxdim=paddata(max(cellfun(@minndims,x)),1,FillValue=1);
	if options.BroadcastSize
		sz=cell2mat(cellfun(@(x)size(x,1:maxdim),x(:),UniformOutput=false));
		sz(sz==1)=nan;
		maxsz=max(sz,[],1,"omitmissing");
		x=cellfun(@(x)broadcast(x,maxsz),x,UniformOutput=false);
	end
	[y{1:nargout}]=fun(x{:},options.AdditionalInput{:});
end