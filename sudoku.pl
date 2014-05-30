%:- use_module(library(bounds)).
make_domain(X, OUT) :-
	(X=1; X=2; X=3; X=4; X=5; X=6; X=7; X=8; X=9),
	%X in 1..9,
	OUT = [X].
make_domain(_, OUT) :-
	OUT = [1,2,3,4,5,6,7,8,9].
make_domains([X|[]], [Y]):-
	make_domain(X,Y).
make_domains([X|Tail], [Y|OTail]) :-
	make_domain(X,Y),
	make_domains(Tail,OTail).

% delete_element(Element: int, // что удаляем
%                m: List, // где
%                outList: List, // выход
%                outDeleted: int). // сколько удалили
delete_element(Element, [Element|Tail], Tail, 1).
delete_element(_, [], [], 0).
delete_element(Element, [Y|Tail1], [Y|Tail2], OutDeleted) :-
	delete_element(Element, Tail1, Tail2, OutDeleted).

% all_different(in: Maxrix, out: Matrix)
% принимает массив массивов
% в нем находит массивы, состоящие из 1 элемента
% и удяляет эти элементы из остальных массивов
all_different(L, LOUT) :- all_different_inner(L, L, 0, 0, LOUT).

% all_different_inner(workingmatrix: Matrix, // матрица для поиска одиночных элементов
%		      allmatrix: Matrix, // матрица для сокращения элементов
%                     deleted: int, // сколько было удалено
%                     out: Matrix) // выход
all_different_inner([], L2, 0, _, L2).
all_different_inner([[L|[]]|Tail], AllList, 0, Index, LOUT) :-
	%write(111), nl,
	reduce_domains(L, AllList, 0, TDeleted, Index, 0, TLOUT),
	%write(TDeleted), nl,
	plus(Index, 1, NewIndex),
	all_different_inner(Tail, TLOUT, TDeleted, NewIndex, LOUT).
all_different_inner([_|Tail], AllList, 0, Index, LOUT) :-
	%write(222), nl,
	plus(Index, 1, NewIndex),
	all_different_inner(Tail, AllList, 0, NewIndex, LOUT).
all_different_inner(_, L2, _, _, LOUT) :-
	%write(333), nl,
	all_different_inner(L2, L2, 0, 0, LOUT).

% reduce_domains(el: Vector, // что удаляем
%		 m: Matrix, // откуда
%                deleted: int = 0, // счетчик удалённых
%                deletedout: int, // сколько удалили в итоге
%                out: Matrix) // выход
%
reduce_domains(L, [_|Tail], Deleted, OutDeleted, Index, Index, [[L]|OTail]) :-
	%write(L),
	plus(Index, 1, NewIndex),
	reduce_domains(L,Tail, Deleted, OutDeleted, Index, NewIndex, OTail).
reduce_domains(L, [Element|Tail], Deleted, OutDeleted, TargetIndex, CurIndex, [OutAllList|OTail]) :-
	delete_element(L, Element, OutAllList, HowMuchDeleted),
	plus(Deleted, HowMuchDeleted, NewDeleted),
	plus(CurIndex, 1, NewCurIndex),
	reduce_domains(L, Tail, NewDeleted , OutDeleted, TargetIndex, NewCurIndex, OTail).
reduce_domains(_,Elements, Deleted, Deleted,_, _, Elements).

% main
sudoku(
    [[X11,X12,X13,X14,X15,X16,X17,X18,X19],
     [X21,X22,X23,X24,X25,X26,X27,X28,X29],
     [X31,X32,X33,X34,X35,X36,X37,X38,X39],
     [X41,X42,X43,X44,X45,X46,X47,X48,X49],
     [X51,X52,X53,X54,X55,X56,X57,X58,X59],
     [X61,X62,X63,X64,X65,X66,X67,X68,X69],
     [X71,X72,X73,X74,X75,X76,X77,X78,X79],
     [X81,X82,X83,X84,X85,X86,X87,X88,X89],
     [X91,X92,X93,X94,X95,X96,X97,X98,X99]],
    DomainsRedused) :-
	make_domains(
	    [X11,X12,X13,X14,X15,X16,X17,X18,X19,
	     X21,X22,X23,X24,X25,X26,X27,X28,X29,
	     X31,X32,X33,X34,X35,X36,X37,X38,X39,
	     X41,X42,X43,X44,X45,X46,X47,X48,X49,
	     X51,X52,X53,X54,X55,X56,X57,X58,X59,
	     X61,X62,X63,X64,X65,X66,X67,X68,X69,
	     X71,X72,X73,X74,X75,X76,X77,X78,X79,
	     X81,X82,X83,X84,X85,X86,X87,X88,X89,
	     X91,X92,X93,X94,X95,X96,X97,X98,X99],
	    [D11,D12,D13,D14,D15,D16,D17,D18,D19,
	     D21,D22,D23,D24,D25,D26,D27,D28,D29,
	     D31,D32,D33,D34,D35,D36,D37,D38,D39,
	     D41,D42,D43,D44,D45,D46,D47,D48,D49,
	     D51,D52,D53,D54,D55,D56,D57,D58,D59,
	     D61,D62,D63,D64,D65,D66,D67,D68,D69,
	     D71,D72,D73,D74,D75,D76,D77,D78,D79,
	     D81,D82,D83,D84,D85,D86,D87,D88,D89,
	     D91,D92,D93,D94,D95,D96,D97,D98,D99]),
	sudoku_inner(
	    [[D11,D12,D13,D14,D15,D16,D17,D18,D19],
	     [D21,D22,D23,D24,D25,D26,D27,D28,D29],
	     [D31,D32,D33,D34,D35,D36,D37,D38,D39],
	     [D41,D42,D43,D44,D45,D46,D47,D48,D49],
	     [D51,D52,D53,D54,D55,D56,D57,D58,D59],
	     [D61,D62,D63,D64,D65,D66,D67,D68,D69],
	     [D71,D72,D73,D74,D75,D76,D77,D78,D79],
	     [D81,D82,D83,D84,D85,D86,D87,D88,D89],
	     [D91,D92,D93,D94,D95,D96,D97,D98,D99]],
	    [],
	    DomainsRedused).

% sudoku_inner(In: Matrix,
%              PrevStep: Matrix,
%	       Out: Matrix)
%
sudoku_inner(M1, M1, M1).
sudoku_inner(
    [[D11,D12,D13,D14,D15,D16,D17,D18,D19],
     [D21,D22,D23,D24,D25,D26,D27,D28,D29],
     [D31,D32,D33,D34,D35,D36,D37,D38,D39],
     [D41,D42,D43,D44,D45,D46,D47,D48,D49],
     [D51,D52,D53,D54,D55,D56,D57,D58,D59],
     [D61,D62,D63,D64,D65,D66,D67,D68,D69],
     [D71,D72,D73,D74,D75,D76,D77,D78,D79],
     [D81,D82,D83,D84,D85,D86,D87,D88,D89],
     [D91,D92,D93,D94,D95,D96,D97,D98,D99]],
    _,
    DomainsRedused) :-
	all_different([D11,D12,D13,D14,D15,D16,D17,D18,D19], [D1_11, D1_12, D1_13, D1_14, D1_15, D1_16, D1_17, D1_18, D1_19]),
	all_different([D21,D22,D23,D24,D25,D26,D27,D28,D29], [D1_21, D1_22, D1_23, D1_24, D1_25, D1_26, D1_27, D1_28, D1_29]),
	all_different([D31,D32,D33,D34,D35,D36,D37,D38,D39], [D1_31, D1_32, D1_33, D1_34, D1_35, D1_36, D1_37, D1_38, D1_39]),
	all_different([D41,D42,D43,D44,D45,D46,D47,D48,D49], [D1_41, D1_42, D1_43, D1_44, D1_45, D1_46, D1_47, D1_48, D1_49]),
	all_different([D51,D52,D53,D54,D55,D56,D57,D58,D59], [D1_51, D1_52, D1_53, D1_54, D1_55, D1_56, D1_57, D1_58, D1_59]),
	all_different([D61,D62,D63,D64,D65,D66,D67,D68,D69], [D1_61, D1_62, D1_63, D1_64, D1_65, D1_66, D1_67, D1_68, D1_69]),
	all_different([D71,D72,D73,D74,D75,D76,D77,D78,D79], [D1_71, D1_72, D1_73, D1_74, D1_75, D1_76, D1_77, D1_78, D1_79]),
	all_different([D81,D82,D83,D84,D85,D86,D87,D88,D89], [D1_81, D1_82, D1_83, D1_84, D1_85, D1_86, D1_87, D1_88, D1_89]),
	all_different([D91,D92,D93,D94,D95,D96,D97,D98,D99], [D1_91, D1_92, D1_93, D1_94, D1_95, D1_96, D1_97, D1_98, D1_99]),

	all_different([D1_11, D1_21, D1_31, D1_41, D1_51, D1_61, D1_71, D1_81, D1_91], [D2_11, D2_21, D2_31, D2_41, D2_51, D2_61, D2_71, D2_81, D2_91]),
	all_different([D1_12, D1_22, D1_32, D1_42, D1_52, D1_62, D1_72, D1_82, D1_92], [D2_12, D2_22, D2_32, D2_42, D2_52, D2_62, D2_72, D2_82, D2_92]),
	all_different([D1_13, D1_23, D1_33, D1_43, D1_53, D1_63, D1_73, D1_83, D1_93], [D2_13, D2_23, D2_33, D2_43, D2_53, D2_63, D2_73, D2_83, D2_93]),
	all_different([D1_14, D1_24, D1_34, D1_44, D1_54, D1_64, D1_74, D1_84, D1_94], [D2_14, D2_24, D2_34, D2_44, D2_54, D2_64, D2_74, D2_84, D2_94]),
	all_different([D1_15, D1_25, D1_35, D1_45, D1_55, D1_65, D1_75, D1_85, D1_95], [D2_15, D2_25, D2_35, D2_45, D2_55, D2_65, D2_75, D2_85, D2_95]),
	all_different([D1_16, D1_26, D1_36, D1_46, D1_56, D1_66, D1_76, D1_86, D1_96], [D2_16, D2_26, D2_36, D2_46, D2_56, D2_66, D2_76, D2_86, D2_96]),
	all_different([D1_17, D1_27, D1_37, D1_47, D1_57, D1_67, D1_77, D1_87, D1_97], [D2_17, D2_27, D2_37, D2_47, D2_57, D2_67, D2_77, D2_87, D2_97]),
	all_different([D1_18, D1_28, D1_38, D1_48, D1_58, D1_68, D1_78, D1_88, D1_98], [D2_18, D2_28, D2_38, D2_48, D2_58, D2_68, D2_78, D2_88, D2_98]),
	all_different([D1_19, D1_29, D1_39, D1_49, D1_59, D1_69, D1_79, D1_89, D1_99], [D2_19, D2_29, D2_39, D2_49, D2_59, D2_69, D2_79, D2_89, D2_99]),

	all_different([D2_11, D2_12, D2_13, D2_21, D2_22, D2_23, D2_31, D2_32, D2_33], [D3_11, D3_12, D3_13, D3_21, D3_22, D3_23, D3_31, D3_32, D3_33]),
	all_different([D2_14, D2_15, D2_16, D2_24, D2_25, D2_26, D2_34, D2_35, D2_36], [D3_14, D3_15, D3_16, D3_24, D3_25, D3_26, D3_34, D3_35, D3_36]),
	all_different([D2_17, D2_18, D2_19, D2_27, D2_28, D2_29, D2_37, D2_38, D2_39], [D3_17, D3_18, D3_19, D3_27, D3_28, D3_29, D3_37, D3_38, D3_39]),
	all_different([D2_41, D2_42, D2_43, D2_51, D2_52, D2_53, D2_61, D2_62, D2_63], [D3_41, D3_42, D3_43, D3_51, D3_52, D3_53, D3_61, D3_62, D3_63]),
	all_different([D2_44, D2_45, D2_46, D2_54, D2_55, D2_56, D2_64, D2_65, D2_66], [D3_44, D3_45, D3_46, D3_54, D3_55, D3_56, D3_64, D3_65, D3_66]),
	all_different([D2_47, D2_48, D2_49, D2_57, D2_58, D2_59, D2_67, D2_68, D2_69], [D3_47, D3_48, D3_49, D3_57, D3_58, D3_59, D3_67, D3_68, D3_69]),
	all_different([D2_71, D2_72, D2_73, D2_81, D2_82, D2_83, D2_91, D2_92, D2_93], [D3_71, D3_72, D3_73, D3_81, D3_82, D3_83, D3_91, D3_92, D3_93]),
	all_different([D2_74, D2_75, D2_76, D2_84, D2_85, D2_86, D2_94, D2_95, D2_96], [D3_74, D3_75, D3_76, D3_84, D3_85, D3_86, D3_94, D3_95, D3_96]),
	all_different([D2_77, D2_78, D2_79, D2_87, D2_88, D2_89, D2_97, D2_98, D2_99], [D3_77, D3_78, D3_79, D3_87, D3_88, D3_89, D3_97, D3_98, D3_99]),
	sudoku_inner(
	    [[D3_11, D3_12, D3_13, D3_14, D3_15, D3_16, D3_17, D3_18, D3_19],
	     [D3_21, D3_22, D3_23, D3_24, D3_25, D3_26, D3_27, D3_28, D3_29],
	     [D3_31, D3_32, D3_33, D3_34, D3_35, D3_36, D3_37, D3_38, D3_39],
	     [D3_41, D3_42, D3_43, D3_44, D3_45, D3_46, D3_47, D3_48, D3_49],
	     [D3_51, D3_52, D3_53, D3_54, D3_55, D3_56, D3_57, D3_58, D3_59],
	     [D3_61, D3_62, D3_63, D3_64, D3_65, D3_66, D3_67, D3_68, D3_69],
	     [D3_71, D3_72, D3_73, D3_74, D3_75, D3_76, D3_77, D3_78, D3_79],
	     [D3_81, D3_82, D3_83, D3_84, D3_85, D3_86, D3_87, D3_88, D3_89],
	     [D3_91, D3_92, D3_93, D3_94, D3_95, D3_96, D3_97, D3_98, D3_99]],
	    [[D11,D12,D13,D14,D15,D16,D17,D18,D19],
	     [D21,D22,D23,D24,D25,D26,D27,D28,D29],
	     [D31,D32,D33,D34,D35,D36,D37,D38,D39],
	     [D41,D42,D43,D44,D45,D46,D47,D48,D49],
	     [D51,D52,D53,D54,D55,D56,D57,D58,D59],
	     [D61,D62,D63,D64,D65,D66,D67,D68,D69],
	     [D71,D72,D73,D74,D75,D76,D77,D78,D79],
	     [D81,D82,D83,D84,D85,D86,D87,D88,D89],
	     [D91,D92,D93,D94,D95,D96,D97,D98,D99]],
	    DomainsRedused).

% for gui
sudoku_step(
    [[D11,D12,D13,D14,D15,D16,D17,D18,D19],
     [D21,D22,D23,D24,D25,D26,D27,D28,D29],
     [D31,D32,D33,D34,D35,D36,D37,D38,D39],
     [D41,D42,D43,D44,D45,D46,D47,D48,D49],
     [D51,D52,D53,D54,D55,D56,D57,D58,D59],
     [D61,D62,D63,D64,D65,D66,D67,D68,D69],
     [D71,D72,D73,D74,D75,D76,D77,D78,D79],
     [D81,D82,D83,D84,D85,D86,D87,D88,D89],
     [D91,D92,D93,D94,D95,D96,D97,D98,D99]],
    [[D3_11, D3_12, D3_13, D3_14, D3_15, D3_16, D3_17, D3_18, D3_19],
     [D3_21, D3_22, D3_23, D3_24, D3_25, D3_26, D3_27, D3_28, D3_29],
     [D3_31, D3_32, D3_33, D3_34, D3_35, D3_36, D3_37, D3_38, D3_39],
     [D3_41, D3_42, D3_43, D3_44, D3_45, D3_46, D3_47, D3_48, D3_49],
     [D3_51, D3_52, D3_53, D3_54, D3_55, D3_56, D3_57, D3_58, D3_59],
     [D3_61, D3_62, D3_63, D3_64, D3_65, D3_66, D3_67, D3_68, D3_69],
     [D3_71, D3_72, D3_73, D3_74, D3_75, D3_76, D3_77, D3_78, D3_79],
     [D3_81, D3_82, D3_83, D3_84, D3_85, D3_86, D3_87, D3_88, D3_89],
     [D3_91, D3_92, D3_93, D3_94, D3_95, D3_96, D3_97, D3_98, D3_99]]
) :-
	all_different([D11,D12,D13,D14,D15,D16,D17,D18,D19], [D1_11, D1_12, D1_13, D1_14, D1_15, D1_16, D1_17, D1_18, D1_19]),
	all_different([D21,D22,D23,D24,D25,D26,D27,D28,D29], [D1_21, D1_22, D1_23, D1_24, D1_25, D1_26, D1_27, D1_28, D1_29]),
	all_different([D31,D32,D33,D34,D35,D36,D37,D38,D39], [D1_31, D1_32, D1_33, D1_34, D1_35, D1_36, D1_37, D1_38, D1_39]),
	all_different([D41,D42,D43,D44,D45,D46,D47,D48,D49], [D1_41, D1_42, D1_43, D1_44, D1_45, D1_46, D1_47, D1_48, D1_49]),
	all_different([D51,D52,D53,D54,D55,D56,D57,D58,D59], [D1_51, D1_52, D1_53, D1_54, D1_55, D1_56, D1_57, D1_58, D1_59]),
	all_different([D61,D62,D63,D64,D65,D66,D67,D68,D69], [D1_61, D1_62, D1_63, D1_64, D1_65, D1_66, D1_67, D1_68, D1_69]),
	all_different([D71,D72,D73,D74,D75,D76,D77,D78,D79], [D1_71, D1_72, D1_73, D1_74, D1_75, D1_76, D1_77, D1_78, D1_79]),
	all_different([D81,D82,D83,D84,D85,D86,D87,D88,D89], [D1_81, D1_82, D1_83, D1_84, D1_85, D1_86, D1_87, D1_88, D1_89]),
	all_different([D91,D92,D93,D94,D95,D96,D97,D98,D99], [D1_91, D1_92, D1_93, D1_94, D1_95, D1_96, D1_97, D1_98, D1_99]),

	all_different([D1_11, D1_21, D1_31, D1_41, D1_51, D1_61, D1_71, D1_81, D1_91], [D2_11, D2_21, D2_31, D2_41, D2_51, D2_61, D2_71, D2_81, D2_91]),
	all_different([D1_12, D1_22, D1_32, D1_42, D1_52, D1_62, D1_72, D1_82, D1_92], [D2_12, D2_22, D2_32, D2_42, D2_52, D2_62, D2_72, D2_82, D2_92]),
	all_different([D1_13, D1_23, D1_33, D1_43, D1_53, D1_63, D1_73, D1_83, D1_93], [D2_13, D2_23, D2_33, D2_43, D2_53, D2_63, D2_73, D2_83, D2_93]),
	all_different([D1_14, D1_24, D1_34, D1_44, D1_54, D1_64, D1_74, D1_84, D1_94], [D2_14, D2_24, D2_34, D2_44, D2_54, D2_64, D2_74, D2_84, D2_94]),
	all_different([D1_15, D1_25, D1_35, D1_45, D1_55, D1_65, D1_75, D1_85, D1_95], [D2_15, D2_25, D2_35, D2_45, D2_55, D2_65, D2_75, D2_85, D2_95]),
	all_different([D1_16, D1_26, D1_36, D1_46, D1_56, D1_66, D1_76, D1_86, D1_96], [D2_16, D2_26, D2_36, D2_46, D2_56, D2_66, D2_76, D2_86, D2_96]),
	all_different([D1_17, D1_27, D1_37, D1_47, D1_57, D1_67, D1_77, D1_87, D1_97], [D2_17, D2_27, D2_37, D2_47, D2_57, D2_67, D2_77, D2_87, D2_97]),
	all_different([D1_18, D1_28, D1_38, D1_48, D1_58, D1_68, D1_78, D1_88, D1_98], [D2_18, D2_28, D2_38, D2_48, D2_58, D2_68, D2_78, D2_88, D2_98]),
	all_different([D1_19, D1_29, D1_39, D1_49, D1_59, D1_69, D1_79, D1_89, D1_99], [D2_19, D2_29, D2_39, D2_49, D2_59, D2_69, D2_79, D2_89, D2_99]),

	all_different([D2_11, D2_12, D2_13, D2_21, D2_22, D2_23, D2_31, D2_32, D2_33], [D3_11, D3_12, D3_13, D3_21, D3_22, D3_23, D3_31, D3_32, D3_33]),
	all_different([D2_14, D2_15, D2_16, D2_24, D2_25, D2_26, D2_34, D2_35, D2_36], [D3_14, D3_15, D3_16, D3_24, D3_25, D3_26, D3_34, D3_35, D3_36]),
	all_different([D2_17, D2_18, D2_19, D2_27, D2_28, D2_29, D2_37, D2_38, D2_39], [D3_17, D3_18, D3_19, D3_27, D3_28, D3_29, D3_37, D3_38, D3_39]),
	all_different([D2_41, D2_42, D2_43, D2_51, D2_52, D2_53, D2_61, D2_62, D2_63], [D3_41, D3_42, D3_43, D3_51, D3_52, D3_53, D3_61, D3_62, D3_63]),
	all_different([D2_44, D2_45, D2_46, D2_54, D2_55, D2_56, D2_64, D2_65, D2_66], [D3_44, D3_45, D3_46, D3_54, D3_55, D3_56, D3_64, D3_65, D3_66]),
	all_different([D2_47, D2_48, D2_49, D2_57, D2_58, D2_59, D2_67, D2_68, D2_69], [D3_47, D3_48, D3_49, D3_57, D3_58, D3_59, D3_67, D3_68, D3_69]),
	all_different([D2_71, D2_72, D2_73, D2_81, D2_82, D2_83, D2_91, D2_92, D2_93], [D3_71, D3_72, D3_73, D3_81, D3_82, D3_83, D3_91, D3_92, D3_93]),
	all_different([D2_74, D2_75, D2_76, D2_84, D2_85, D2_86, D2_94, D2_95, D2_96], [D3_74, D3_75, D3_76, D3_84, D3_85, D3_86, D3_94, D3_95, D3_96]),
	all_different([D2_77, D2_78, D2_79, D2_87, D2_88, D2_89, D2_97, D2_98, D2_99], [D3_77, D3_78, D3_79, D3_87, D3_88, D3_89, D3_97, D3_98, D3_99]).
