function A=cell2mat(C,dims,finalize)
%zsc.cell2mat	Improved version of MATLAB function cell2mat
%	A=zsc.cell2mat(C,dims=1:ndims(C),finalize=true) concatenates cell C
%	along dims, and remove cell layer if all dimensions are selected and
%	finalize==true. Unlike builtin cell2mat, this one supports objects like
%	string, and automatically broadcasts.
%
%	Example:
%	>> zsc.cell2mat({[1,2],2;3,4},1)
%
%	ans =
%
%	  1×2 cell array
%
%	    {2×2 double}    {2×1 double}
%
%	ans{:}
%
%	ans =
%
%	     1     2
%	     3     3
%
%
%	ans =
%
%	     2
%	     4
%
%	See also cell2mat

%	Copyright Chris H. Zhao 2025
	arguments(Input)
		C{mustBeUnderlyingType(C,"cell")}
		dims(1,:)double{mustBeInteger,mustBePositive}=1:ndims(C)
		finalize(1,1)logical=true
	end
	arguments(Output)
		A
	end
	A=C;
	for dim=dims
		A=num2cell(A,dim);
		A=cellfun(@(x)zsc.cat(dim,x{:}),A,UniformOutput=false);
	end
	if isequal(dims,1:ndims(C))&&finalize
		A=A{1};
	end
end