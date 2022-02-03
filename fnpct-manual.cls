% --------------------------------------------------------------------------
% the FNPCT package
% 
%   footnotes' interaction with punctuation
% 
% --------------------------------------------------------------------------
% Clemens Niederberger
% Web:    https://github.com/cgnieder/fnpct/
% E-Mail: clemens@cnltx.de
% --------------------------------------------------------------------------
% Copyright 2012--2022 Clemens Niederberger
% 
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3c
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2008/05/04 or later.
% 
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is Clemens Niederberger.
% --------------------------------------------------------------------------
\RequirePackage[multiple]{fnpct}
\ProvidesClass{fnpct-manual}[2022/02/03]

\LoadClass[load-preamble,add-index]{cnltx-doc}
\RequirePackage{imakeidx}

\setcnltx{
  package  = {fnpct} ,
  info     = {footnotes' interaction with punctuation} ,
  authors  = Clemens Niederberger ,
  email    = clemens@cnltx.de ,
  url      = https://github.com/cgnieder/fnpct/ ,
  abstract = {%
      The \fnpct\ package basically does two things to footnotes: if footnote
      marks are followed by a punctuation mark the order of footnote and
      punctuation mark is reversed and the kerning gets adjusted.  As a side
      effect mutiple footnotes and footnote ranges are easily obtained..%
  },
  add-cmds = {
    AdaptNote,
    AdaptNoteName,
    AddPunctuation,
    % kfc,
    % kfp,
    multfootnote,
    MultVariant,
    setfnpct
  } ,
  add-silent-cmds = {
    @mpfn,
    anote,
    anotecontent,
    arabic,
    DeclareNewFootnote,
    endnote,
    footcite
    footnoteB,
    footref,
    IfBooleanTF,
    IfNoValueTF,
    multendnote,
    multfootcite,
    multparnote,
    multsidenote,
    myfn,
    newfootnotes,
    parnote,
    parnotes,
    sidenote,
    theendnotes,
    thempfootnote
  } ,
  makeindex-setup = {options={-s cnltx.ist},columns=3,columnsep=1em} ,
  index-setup = {othercode=\footnotesize,level=\addsec}
}

\RequirePackage{array,booktabs}

\RequirePackage{endnotes}
\RequirePackage{parnotes}
\RequirePackage{sepfootnotes}

\newfootnotes{a}

\renewcommand\thempfootnote{\arabic{mpfootnote}}

\DeclareTranslation{english}{cnltx-default}{Initial}

\protected\def\@versionstar{\raisebox{-.25em}{*}}
\newcommand\versionstar{\texorpdfstring{\@versionstar}{*}}

\newcommand*\TF{\textcolor{red}{\uline{\code{\textcolor{cs}{\textit{TF}}}}}}

\RequirePackage{fontawesome}
\RequirePackage{datetime2}
\DTMsetup{useregional=numeric,datesep=/}
\newrobustcmd*\fnpct@add@version[2]{%
  \csdef{ac@ver@#2}{%
    \DTMdate{#1}%
    \csgdef{ac@ver@#2used}{}%
    \csdef{ac@ver@#2}{\DTMdate{#1}}%
  }%
}

\newrobustcmd*\ac@date[1]{\ifcsdef{ac@ver@#1used}{}{ (\csuse{ac@ver@#1})}}
\newrobustcmd*\ac@ifnew[1]{\ifcsstring{c_fnpct_version_tl}{#1}}
\newrobustcmd*\ac@NEW{\faStarO\ New}

\renewrobustcmd*\sinceversion[1]{%
  \ac@ifnew{#1}%
    {\cnltx@version@note{\textcolor{red}{\ac@NEW}}}%
    {\cnltx@version@note{\GetTranslation{cnltx-introduced}~v#1\ac@date{#1}}}%
}
\renewrobustcmd*\changedversion[1]{%
  \cnltx@version@note{\GetTranslation{cnltx-changed}~v#1\ac@date{#1}}%
}

\newnote*\sincechanged[2]{%
  \GetTranslation{cnltx-introduced}~#1\ac@date{#1},
  changed with ~v#2\ac@date{#2}\ac@ifnew{#2}{ \ac@NEW}{}%
}

\RenewDocumentEnvironment{commands}{}
  {%
    \cnltx@set@catcode_{12}%
    \let\command\cnltx@command
    \cnltxlist
  }
  {\endcnltxlist}
  
\RequirePackage{tcolorbox,xsimverb}
\tcbuselibrary{skins,breakable}
\tcbset{enhanced,enhanced jigsaw}

\newtcolorbox{bewareofthedog}{
  colback  = red!2!white!98 ,
  colframe = red ,
  underlay={%
    \path[draw=none]
      (interior.south west)
      rectangle node[red]{\Huge\bfseries !}
      ([xshift=-4mm]interior.north west);
    }%
}

\newtcolorbox{cnltxcode}[1][]{
  boxrule = 1pt ,
  colback = cnltxbg ,
  colframe = cnltx ,
  arc = 5pt ,
  beforeafter skip = .5\baselineskip ,%
  #1%
}

\newcommand*\fnpctman@readoptions[1]{%
  \catcode`\^^M=13
  \fnpctman@read@options{#1}%
}

\begingroup
\catcode`\^^M=13
\gdef\fnpctman@read@options#1#2^^M{%
  \endgroup
  \ifblank{#2}{}{\fnpctman@read@options@#2}%
  #1%
  \XSIMfilewritestart*{\jobname.tmp}%
}%
\endgroup
\def\fnpctman@read@options@[#1]{\pgfqkeys{/cnltx}{#1}}

\RenewDocumentEnvironment{sourcecode}{}
  {%
    \begingroup
    \fnpctman@readoptions{%
      \setlength\cnltx@sidebysidewidth
        {\dimexpr .45\columnwidth -\lst@xleftmargin -\lst@xrightmargin\relax}%
      \expanded{%
        \noexpand\lstset{
          style=cnltx,
          \ifboolexpe{ bool {cnltx@sidebyside} and not bool {cnltx@codeonly} }
            {linewidth=\cnltx@sidebysidewidth,}{}%
          \expandonce\cnltx@local@listings@options
        }%
      }%
      \XSIMgobblechars{2}%
    }%
  }
  {%
    \XSIMfilewritestop
    \cnltxcode[breakable]%
    \lstinputlisting[style=cnltx]{\jobname.tmp}%
    \endcnltxcode
  }

\RenewDocumentEnvironment{example}{}
  {%
    \begingroup
    \fnpctman@readoptions{%
      \setlength\cnltx@sidebysidewidth
        {\dimexpr .45\columnwidth -\lst@xleftmargin -\lst@xrightmargin\relax}%
      \expanded{%
        \noexpand\lstset{
          style=cnltx,
          \ifboolexpe{ bool {cnltx@sidebyside} and not bool {cnltx@codeonly} }
            {linewidth=\cnltx@sidebysidewidth,}{}%
          \expandonce\cnltx@local@listings@options
        }%
      }%
      \XSIMgobblechars{2}%
    }%
  }
  {%
    \XSIMfilewritestop
    \ifbool{cnltx@sidebyside}
      {%
        \cnltxcode
        \noindent
        \minipage[c]{\cnltx@sidebysidewidth}%
          \cnltx@pre@source@hook
          \lstinputlisting[style=cnltx] {\jobname.tmp}%
          \cnltx@after@source@hook
        \endminipage\hfill
        \minipage[c]{\cnltx@sidebysidewidth}%
          \cnltx@pre@example@hook
          \input {\jobname.tmp}%
          \cnltx@after@example@hook
        \endminipage
      }
      {%
        \cnltxcode[breakable]%
        \cnltx@pre@source@hook
        \lstinputlisting{\jobname.tmp}%
        \cnltx@after@source@hook
        \ifbool{cnltx@float}{}{%
          \tcblower
          \cnltx@pre@example@hook
          \input {\jobname.tmp}%
          \cnltx@after@example@hook
        }
      }%
    \endcnltxcode
    \ifbool{cnltx@float}{%
      \cnltx@float@start
      \ifdefvoid\cnltx@float@caption{}{\caption{\cnltx@float@caption}}%
      \expandafter\end\expandafter{\cnltx@float@type}%
    }{}%
  }

\RequirePackage[
  backend=biber,
  style=cnltx,
  sortlocale=en_US,
  indexing=cite]{biblatex}
\RequirePackage{csquotes,varioref}

\defbibheading{bibliography}[\bibname]{\addsec{#1}}

\RequirePackage[biblatex]{embrac}[2012/06/29]
\ChangeEmph{[}[,.02em]{]}[.055em,-.08em]
\ChangeEmph{(}[-.01em,.04em]{)}[.04em,-.05em]

\NewDocumentCommand\noranges{sm}{%
  \begin{bewareofthedog}
    \IfBooleanTF{#1}{\pkg*}{\pkg}{#2} cannot be used together with
    \keyis{ranges}{true}.
  \end{bewareofthedog}
}

\RequirePackage{hyperref}

% additional packages:
\RequirePackage{longtable,array,booktabs,enumitem,amssymb}

% ----------------------------------------------------------------------------
\newrobustcmd*\pdfdisable[2]{%
  \csdef{fnpct@@\cnltx@stripbs#1}##1{#2}%
  \def#1##1{%
    \csuse{fnpct_if_star_gobble:nTF}{##1}%
      {\csuse{fnpct@@\cnltx@stripbs#1}}%
      {\csuse{fnpct@@\cnltx@stripbs#1}{##1}}%
  }%
}

\pdfstringdefDisableCommands{%
  \pdfdisable\template{#1}%
  \pdfdisable\property{#1}
  \pdfdisable\cs{\string\\#1}%
  \pdfdisable\cmd{\string\\#1}%
  \pdfdisable\option{#1}%
  \def\oarg#1{[<#1>]}%
  \def\Oarg#1{[#1]}%
  \def\marg#1{\{<#1>\}}%
  \def\Marg#1{\{#1\}}%
  \def\fnpct{fnpct}%
  \def\LaTeX{LaTeX}%
  \def\TeX{TeX}%
}
% ----------------------------------------------------------------------------
\fnpct@add@version{2012-05-22}{0.1}
\fnpct@add@version{2012-05-23}{0.1a}
\fnpct@add@version{2012-05-26}{0.2}
\fnpct@add@version{2012-06-01}{0.2a}
\fnpct@add@version{2012-06-07}{0.2b}
\fnpct@add@version{2012-06-28}{0.2c}
\fnpct@add@version{2012-07-07}{0.2d}
\fnpct@add@version{2012-07-24}{0.2e}
\fnpct@add@version{2012-08-27}{0.2f}
\fnpct@add@version{2012-11-14}{0.2g}
\fnpct@add@version{2013-01-18}{0.2h}
\fnpct@add@version{2013-01-21}{0.2i}
\fnpct@add@version{2013-02-22}{0.2j}
\fnpct@add@version{2013-04-07}{0.2k}
\fnpct@add@version{2013-04-16}{0.3}
\fnpct@add@version{2013-06-14}{0.3a}
\fnpct@add@version{2013-12-22}{0.4}
\fnpct@add@version{2013-12-23}{0.4a}
\fnpct@add@version{2014-03-10}{0.4b}
\fnpct@add@version{2015-02-20}{0.4c}
\fnpct@add@version{2015-04-23}{0.4d}
\fnpct@add@version{2016-03-25}{0.4e}
\fnpct@add@version{2019-02-17}{0.4f}
\fnpct@add@version{2019-09-30}{0.4g}
\fnpct@add@version{2019-10-05}{0.5}
\fnpct@add@version{2020-01-12}{0.5a}
\fnpct@add@version{2021-01-21}{1.0}
\fnpct@add@version{2022-01-04}{1.0a}
\fnpct@add@version{2022-01-29}{1.0b}
\fnpct@add@version{2022-02-03}{1.1}

\endinput
