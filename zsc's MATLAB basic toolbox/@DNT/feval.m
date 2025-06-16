function DNTs=feval(f,DNTs,options)
%FEVAL	Eval a function on DNTs with automatic broadcasting
%	*DNTs=FEVAL(f,*DNTs,AdditionalInput={},BroadcastSize=true) broadcasts
%	*DNTs against each other if BroadcastSize==true, and apply fun.
%	*AdditionalInput are not broadcast. Set fun to @deal or use ndgrid to
%	manually broadcast DNTs.
%
%	Example:
%	>> [a,b]=FEVAL(funcat(@min,@max),DNT(1:5,"a"),DNT(1:5,"b"))
%
%	a =
%
%	  5×5 DNT double matrix
%
%	         b         1    2    3    4    5
%	    a
%
%	    1              1    1    1    1    1
%	    2              1    2    2    2    2
%	    3              1    2    3    3    3
%	    4              1    2    3    4    4
%	    5              1    2    3    4    5
%
%
%	b =
%
%	  5×5 DNT double matrix
%
%	         b         1    2    3    4    5
%	    a
%
%	    1              1    2    3    4    5
%	    2              2    2    3    4    5
%	    3              3    3    3    4    5
%	    4              4    4    4    4    5
%	    5              5    5    5    5    5
%
%	See also feval, DNT

%	Copyright 2024–2025 Chris H. Zhao
	arguments(Input)
		f(1,1)function_handle
	end
	arguments(Input,Repeating)
		DNTs DNT
	end
	arguments(Input)
		options.AdditionalInput(:,1)cell={}
		options.BroadcastSize(1,1)logical=true
	end
	arguments(Output,Repeating)
		DNTs DNT
	end
	star=starclass;
	dstar=dstarclass;
	dimnames=unique([star{DNTs,2}{1}.dimnames]);
	[star{"DNTs",2}{1}.dimnames]=star{cellfun(@(x)[x.dimnames,setdiff(dimnames,x.dimnames)],DNTs,UniformOutput=false),2}{:};
	[tmp{1:nargout}]=zsc.feval(f,star{DNTs,2}{1}.data,dstar{options});
	DNTs=repmat(DNTs(1),[1,numel(tmp)]);
	[star{"DNTs",2}{1}.data]=tmp{:};
end