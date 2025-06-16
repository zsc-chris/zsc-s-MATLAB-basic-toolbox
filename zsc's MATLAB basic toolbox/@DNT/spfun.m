function DNTs=spfun(f,DNTs)
%SPFUN	Apply function to nonzero matrix elements
%	*DNTs=SPFUN(f,*DNTs)
%
%	Example:
%	>> SPFUN(@(x,y)x+y+1,DNT(sparse([1,0;0,1])),DNT(sparse([1,0;1,0])))
%
%	ans =
%
%	  2×2 DNT double matrix
%
%	          x'                       1                 2
%	     x
%
%	     1                (1,1)        3          All zero
%	     2                (1,1)        3    (1,1)        3
%
%	See also spfun, DNT

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		f(1,1)function_handle
	end
	arguments(Input,Repeating)
		DNTs DNT
	end
	arguments(Output,Repeating)
		DNTs DNT
	end
	[DNTs{:}]=feval(@deal,DNTs{:});
	ind=find(gather(DNTs{1}));
	for i=2:numel(DNTs)
		ind=union(ind,find(gather(DNTs{i})));
	end
	star=starclass;
	for i=ind(:)'
		[tmp_{1:nargout}]=f(star{cellfun(@(x)full(x.data(i)),DNTs),2});
		if ~exist("tmp","var")
			tmp=repmat(DNTs(1),[numel(tmp_),1]);
		end
		for j=1:numel(tmp_)
			tmp{j}.data(i)=tmp_{j};
		end
	end
	DNTs=tmp;
end