function ret=numArgumentsFromSubscript(self,s,indexingContext)
%numArgumentsFromSubscript	Number of arguments for indexing methods
%	ret=numArgumentsFromSubscript(self,s,indexingContext)
%	For complete description see <a href="matlab:help DNT/subsref
%	-displayBanner">DNT/subsref</a>.
%
%	See also DNT/subsref

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self DNT
		s(1,:)struct
		indexingContext(1,1)matlab.mixin.util.IndexingContext
	end
	arguments(Output)
		ret double{mustBeInteger,mustBeNonnegative}
	end
	if s(1).type=="."
		if zsc.isproperty("DNT",s(1).subs)||(zsc.ismethod("DNT",s(1).subs)||zsc.ismethod("DNT",s(1).subs,false)&&zsc.ismethod("DNT",s(1).subs+"_"))&&indexingContext~=matlab.mixin.util.IndexingContext.Assignment
			ret=builtin("numArgumentsFromSubscript",self,s,indexingContext);
		else
			ret=builtin("numArgumentsFromSubscript",gather(self),s,indexingContext);
		end
	elseif s(1).type=="{}"
		if indexingContext==matlab.mixin.util.IndexingContext.Assignment
			[self,subs]=parsedimargsindexing(self,s(1).subs,"subsasgn");
		else
			[self,subs]=parsedimargsindexing(self,s(1).subs,"subsref");
		end
		ret=prod(cellfun(@numel,subs(2,:)));
		zsc.assert(ret==1||isscalar(s),message("MATLAB:index:expected_one_output_from_intermediate_indexing","{}",ret))
		if ret~=1
			return
		end
		s_=s(1);
		s_.type="()";
		s(1).subs={':'};
		ret=numArgumentsFromSubscript(gather(subsref(self,s_)),s,indexingContext);
	else
		ret=numArgumentsFromSubscript(subsref(self,s(1)),s(2:end),indexingContext);
	end
end