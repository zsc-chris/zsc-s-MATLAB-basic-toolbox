function ret=broadcast(x,sz)
%BROADCAST	Broadcast array to size
%	ret=BROADCAST(x,sz/*sz) supports numel(sz)<2. Use nan or [] for
%	non-broadcasting dimension.
%
%	See also bsxfun, repmat

%	Copyright 2025 Chris H. Zhao
	arguments
		x
	end
	arguments(Repeating)
		sz{mustBeTrue("@(sz)isequal(sz,[])||isrow(sz)",sz,VariableNames="sz")}
	end
	if isscalar(sz)
		sz=sz{1};
		if isequal(sz,[])
			ret=x;
		else
			sz=fillmissing(sz./size(x,1:numel(sz)),"constant",1);
			ret=zsc.repmat(x,sz);
		end
	else
		sz(cellfun(@(x)isequal(x,[]),sz))={nan};
		sz=cell2mat(sz);
		sz=fillmissing(sz./size(x,1:numel(sz)),"constant",1);
		ret=zsc.repmat(x,sz);
	end
end