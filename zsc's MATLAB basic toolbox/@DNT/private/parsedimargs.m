function dimargs=parsedimargs(dimnames,dimargs,supportscalar)
%PARSEDIMARGS	Parse dimensional arguments
%	subs=parsedimargs(dimnames,dimargs,supportscalar=true)

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		dimnames(1,:)string
		dimargs(1,:)cell
		supportscalar(1,1)logical=true
	end
	arguments(Output)
		dimargs(2,:)cell
	end
	dstar=dstarclass;
	if isempty(dimargs)
		dimargs=cell(2,0);
	elseif isscalar(dimargs)&&(isstruct(dimargs{1})||isa(dimargs{1},"dictionary")||isa(dimargs{1},"table"))
		dimargs=dstar(dimargs{1});
	elseif isnumeric(dimargs{1})
		if supportscalar&&(isscalar(dimargs)||isstring(dimargs{2}))
			if isscalar(dimargs)
				dimargs{2}=[dimnames(1:min(numel(dimargs{1}),numel(dimnames))),dnt.gennewdims(numel(dimnames)+1:numel(dimargs{1}))];
			end
			dimargs=dstar(table(dimargs{2}',dimargs{1}'));
		else
			dimargs=[dimargs;dimargs];
			dimargs(1,:)=num2cell([dimnames(1:min(size(dimargs,2),numel(dimnames))),dnt.gennewdims(numel(dimnames)+1:size(dimargs,2))]);
		end
	else
		dimargs=reshape(dimargs,2,[]);
	end
end