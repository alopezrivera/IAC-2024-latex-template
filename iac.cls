%% iac.cls
%% Copyright 2024 Antonio López Rivera
% 
% LaTeX class for the 2024 International Astronautical Congress 
% of the International Astronautical Federation (IAF).
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2008 or later.
%
% This work consists of this class file, iac.cls, and the template
% files template.tex and references.bib.
%%%%%%%%%%%%%%%%

%====================================
% 
%             Prelude
% 
%====================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iac}[2024 International Astronautical Congress conference paper LaTeX class]

%====================================
% 
%              Options
% 
%====================================



\RequirePackage{kvoptions}

\DeclareStringOption[ieee]{bibstyle}        % Citation style
\DeclareBoolOption{lockfloats}              % Prevent floats from skipping sections
\DeclareBoolOption{flushbottom}             % Align columns at the bottom of the page
\DeclareBoolOption{fnsymbols}              % Symbolic footnotes
\ProcessKeyvalOptions*\relax

% Pass unknown to article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions\relax

%====================================
% 
%          Load parent class
% 
%====================================

\LoadClass[twocolumn,letter paper,10pt]{article}

%====================================
% 
%           Page dimensions
% 
%====================================

\RequirePackage[
    margin=2.5cm,
    top=2.5cm,
    headsep=1cm,
    bottom=3.5cm
]{geometry}

% Column separation
\setlength{\columnsep}{0.5cm}

% Footer position
\setlength{\footskip}{
    \dimexpr
    % Place footer 1.5cm above bottom of the page
    (
        % Page height
        \paperheight
        -
        % Distance from top of page to bottom of text
        (
            1in+
            \voffset+
            \topmargin+
            \headheight+
            \headsep+
            \textheight
        )
    ) - 1.5cm
}

%====================================
% 
%             Packages
% 
%====================================


\RequirePackage{etoolbox}                               % Internals for class programming
\RequirePackage{xcolor}                                 % Colors
\RequirePackage{graphicx}                               % Graphics
\RequirePackage{booktabs}                               % Improved tables
\RequirePackage{adjustbox}                              % Adjust width of tables
\RequirePackage{multirow}                               % Multirow cells in tables
\RequirePackage{fancyhdr}                               % Header and footer settings
\RequirePackage{lastpage}                               % Reference total number of pages in document
\RequirePackage[                                        % Title settings
    explicit,
    compact,
    % nobottomtitles,
]{titlesec}             
\RequirePackage{alphalph}                               % Number to letter conversion
\RequirePackage{caption}                                % Captions
\RequirePackage{fmtcount}                               % Ordinal numbering
\RequirePackage{contour}                                % Underlines
\RequirePackage[                                        % Underlines: normalem to avoid underlining all \emph'sized words (bibliography entries)
    normalem
]{ulem}
\RequirePackage{float}                                  % [H] for figures and tables
\RequirePackage{microtype}                              % Microtypographic adjustments to save space
\ifiac@lockfloats
    \RequirePackage[
        section
    ]{placeins}                                         % Prevent floating environments from drifting beyond their sections
\fi

% Math typesetting
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amstext}
\RequirePackage{amsfonts}
\RequirePackage{bm}
\RequirePackage{mathtools}

% Math structures
\RequirePackage{array}                                  % Arrays
\RequirePackage{empheq}                                 % Grouped equations
\RequirePackage{amsthm}                                 % Theorems
\RequirePackage{thmtools}                               % List of theorems
\RequirePackage[ruled]{algorithm2e}                     % Algorithms
\RequirePackage[short]{optidef}                         % Optimization problems

% Math and scientific symbols and utilities
\RequirePackage{siunitx}                                % Units
\sisetup{detect-all, output-exponent-marker=\ensuremath{\mathrm{e}}}
\RequirePackage[                                        % Chemistry typesetting
    version=4
]{mhchem}
\RequirePackage{extarrows}                              % Labelled arrows and signs
\RequirePackage{gensymb}                                % Generic symbols for text and math mode
\RequirePackage{latexsym}                               % Additional symbols
\RequirePackage{optidef}                                % Bolza problems

% Links and cross-references
\RequirePackage[                                        % Links and cross-references
    colorlinks = false,
    allcolors  = blue,
    unicode    = true
]{hyperref}
\RequirePackage{xurl}                                   % Force URLs to column width

% Bibliography
\RequirePackage[
    backend=biber,
    style=\iac@bibstyle,
    citestyle=numeric-comp
]{biblatex}                                             % Biblatex citation engine and style
\RequirePackage[capitalise]{cleveref}                   % Chained citations
\RequirePackage{csquotes}                               % Recommended addition for citations
\RequirePackage[bottom]{footmisc}                       % Footnotes
\RequirePackage{enotez}

% Other
\RequirePackage{kantlipsum}                             % Kantian lorem ipsum

%====================================
% 
%          Text formatting
% 
%====================================

% Reference formatting
\renewcommand*{\sectionautorefname}{Section}
\renewcommand*{\subsectionautorefname}{Subsection}
\renewcommand*{\subsubsectionautorefname}{Subsection}
\renewcommand*{\equationautorefname}{Eq.}
\renewcommand*{\figureautorefname}{Fig.}
\renewcommand*{\tableautorefname}{Table}
\renewcommand*{\algorithmautorefname}{Algorithm}
\providecommand*{\listingautorefname}{Listing}

% Captions
\captionsetup[figure]{
    name=Fig.,
    format=hang,
    indention=-20pt,
    labelsep=period
}
\captionsetup[table]{
    format=hang,
    indention=-24pt,
    labelsep=period
}

% Footnotes
\newcounter{symbolfootnote}
\NewDocumentCommand{\symbolfootnote}{ O{2} m }{%
    \setcounter{symbolfootnote}{\value{footnote}}%
    \renewcommand*{\thefootnote}{\fnsymbol{footnote}}%
    \footnote[#1]{#2}%
    \setcounter{footnote}{\value{symbolfootnote}}%
    \renewcommand*{\thefootnote}{\arabic{footnote}}%
}

%====================================
% 
%          Body typesetting
% 
%====================================

% Body font (Nimbus Roman, akin to Times New Roman)
\RequirePackage{fontspec}
\setmainfont{TeX Gyre Termes}

% Bibliography
% \DeclareFieldFormat{labelnumberwidth}{\mkbibbrackets{#1}}

% Align colunms at bottom of page
\ifiac@flushbottom
    % Increase paragraph skip glue
    \setlength{\parskip}{1ex plus 2ex}
    % Align colums
    \AtBeginDocument{\flushbottom}%
\fi

% Sections
\titleformat{\section}
    {\normalfont\bfseries}
    {\arabic{section}.~}
    {0pt}
    {\raggedright#1}
\titleformat{\subsection}
    {\normalfont\itshape}
    {\arabic{section}.\arabic{subsection}~}
    {0pt}
    {\raggedright#1}
\titleformat{\subsubsection}
    {\normalfont\itshape}
    {\arabic{section}.\arabic{subsection}.\arabic{subsubsection}~}
    {0pt}
    {\raggedright#1}

% Tables
\newcommand{\thickhline}{%
    \noalign {\ifnum 0=`}\fi \hrule height 2pt
    \futurelet \reserved@a \@xhline
}
\newcolumntype{"}{@{\hskip\tabcolsep\vrule width 1pt\hskip\tabcolsep}}
% Increase line separation to make room for exponents in table entries
\renewcommand{\arraystretch}{1.2}

% Footnotes with symbols
\ifiac@fnsymbols
    \newcommand*{\fnsymbolsingle}[1]{%
        \ensuremath{%
        \ifcase#1%
            \or \dagger
            \or \ddagger
            \or \mathsection
            \or \mathparagraph
            \else
              \@ctrerr
        \fi
        }%
    }
    
    \newalphalph{\fnsymbolmult}[mult]{\fnsymbolsingle}{}
    \renewcommand*{\thefootnote}{%
        \fnsymbolmult{\value{footnote}}%
    }
    
    \def\tagform@#1{\maketag@@@{[#1]\@@italiccorr}}
\fi

% URLs
\renewcommand\UrlFont{\ttfamily}

% Underlines
\renewcommand{\ULdepth}{1.8pt}
\contourlength{0.8pt}
\let\@uline\uline
\renewcommand{\uline}[1]{%
  \@uline{\phantom{#1}}%
  \llap{\contour{white}{#1}}%
}

% Ordinal numbers
\newcommand{\nth}[1]{\ordinalnum{#1}}

% Shorthand years
\newcommand*{\yearshorthand}[1]{\expandafter\@gobbletwo\number\numexpr#1\relax}

%====================================
% 
%           Math typesetting
% 
%====================================

% Symbols
\let\@forall\forall
\renewcommand{\forall}{\ensuremath{\,\@forall\,}}
\DeclareRobustCommand{\vect}[1]{\vec{#1}}
\renewcommand*{\qed}{\quad\square}
\newcommand{\indep}{\ensuremath{\perp\!\!\!\perp}}

% Character definitions
\mathchardef\mathmul=\mathcode`*
\mathcode`*=\cdot

% Operators
\DeclareMathOperator{\E}{\mathbb{E}}
\DeclareMathOperator{\prob}{p}
\DeclareMathOperator{\tr}{tr}
\DeclareMathOperator{\diff}{\mathop{}\!{d}}
\DeclareMathOperator{\conv}{\ast}

% Paired delimiters
\DeclarePairedDelimiter{\ceil}{\lceil}{\rceil}
\let\oldceil\ceil
\def\ceil{\@ifstar{\oldceil}{\oldceil*}}
\DeclarePairedDelimiter{\abs}{\lvert}{\rvert}
\let\oldabs\abs
\def\abs{\@ifstar{\oldabs}{\oldabs*}}
\DeclarePairedDelimiter{\norm}{\lVert}{\rVert}
\let\oldnorm\norm
\def\norm{\@ifstar{\oldnorm}{\oldnorm*}}

% Accents
\newcommand{\olsi}[1]{\,\overline{\!{#1}}} % overline short italic
\newcommand{\ols}[1]{\mskip.5\thinmuskip\overline{\mskip-.5\thinmuskip {#1} \mskip-.5\thinmuskip}\mskip.5\thinmuskip} % overline short

% Equation spacing
\g@addto@macro\normalsize{%
  \setlength\abovedisplayskip{2.5pt}%
  \setlength\belowdisplayskip{7.5pt}%
  \setlength\abovedisplayshortskip{2.5pt}%
  \setlength\belowdisplayshortskip{7.5pt}%
}

% Units
\DeclareSIUnit{\rad}{rad}

% Algorithms
\setlength\algoheightrule{2pt}
\setlength\algotitleheightrule{1pt}

%====================================
% 
%            IAC specifics
% 
%====================================

% Author
\newcounter{authcount}
\newcounter{contactauthor}
\NewDocumentCommand{\IACauthor}{ s m m m }{%
    \stepcounter{authcount}%
    \csdef{iac@author\theauthcount}{#2}%
    \csdef{iac@affiliation\theauthcount}{#3}%
        \csdef{iac@email\theauthcount}{#4}%
    \IfBooleanT{#1}{\setcounter{contactauthor}{\theauthcount}}%
}

% Abstract
\renewcommand{\abstract}[1]{
    \def\iac@abstract{
        \vspace*{-2 em} % Adjust the space before paragraphs
        \begin{center}
            \bfseries Abstract
        \end{center}
        \vspace*{-0.8em} % Adjust the space after paragraphs
        \setlength{\parindent}{0.5cm} % Indent the first line of text
        \setlength{\parskip}{0pt} % Single spacing
        
        #1
    }
}

% Conference details
\NewDocumentCommand{\IACconference}{m}{\def\iac@conference{#1}}
\NewDocumentCommand{\IAClocation}{m}{\def\iac@location{#1}}
\NewDocumentCommand{\IACdates}{m}{\def\iac@dates{#1}}
\NewDocumentCommand{\IACyear}{m}{\def\iac@year{#1}}

% Paper details
\newcommand*{\IACpapernumber}[1]{\def\iac@papernumber{#1}}

% Defaults
\IACconference{XX}
\IAClocation{City, Country}
\IACdates{dd-dd Month}
\IACyear{\the\year}
\IACpapernumber{XX-XXXXX}

%====================================
% 
%            Copyright
% 
%====================================

% Copyright Form A (Copyright held by the IAF)
\NewDocumentCommand{\IACcopyrightA}{ m m }{\def\iac@copyright{%
    Copyright \copyright\,#1 by International Astronautical Federation. All rights reserved.%
}}
% Copyright Form B (Copyright held, work licensed to IAF)
% Copyright Form B1 (Copyright retained by the author)
% Copyright Form B2 (Copyright retained by the author’s organisation)
\NewDocumentCommand{\IACcopyrightB}{ m m }{\def\iac@copyright{%
    Copyright \copyright\,#1 by #2. Published by the IAF, with permission and released to the IAF to publish in all forms.%
}}
% Copyright Form C (Authors employed by Government Agencies)
\NewDocumentCommand{\IACcopyrightD}{ m m m }{\def\iac@copyright{%
    Copyright \copyright\,#1 by the International Astronautical Federation. All rights reserved. One or more authors of this work are employees of the #2, which may preclude the work from being subject to copyright in #3, in which event no copyright is asserted in that country.%
}}
% Custom Copyright Form (the copyright form should be preliminarily agreed with IAF Secretariat)
\NewDocumentCommand{\IACcopyrightCustom}{ s o }{\IfValueTF{#2}{%
    \def\iac@copyright{#2}%
}{%
    \IfBooleanTF{#1}{}{
        \PackageWarning{iac}{The custom copyright form should be preliminarily agreed with IAF Secretariat. To ignore this warning - use \IACcopyrightCustom*}%
    }
    \def\iac@copyright{Copyright notice: this paper is subject to a special copyright statement. For more information - please contact the main author.}%
}}

\newcommand\iac@makecopyright{{\iac@copyright}}

%====================================
% 
%            Page design
% 
%====================================

% Paragraph indentation
\setlength\parindent{0.5cm}

% Section spacing
\titlespacing{\section}
    {0pt}
    {1em plus 0.5em}
    {0pt}
\titlespacing{\subsection}
    {0pt}
    {1em plus 0.5em}
    {0pt}
\titlespacing{\subsubsection}
    {0pt}
    {1em plus 0.5em}
    {0pt}

% Headers and footers
\fancypagestyle{fancy}{%
    % Header
    \chead{{\footnotesize\color{gray}%
        \ordinalnum{\iac@conference}~International~Astronautical~Congress~(IAC),~\iac@location,~\iac@dates~\iac@year.\\%
        \iac@copyright%
    }}%
    \lhead{}%
    \rhead{}%
    \renewcommand{\headrulewidth}{0pt}%
    % Footer
    \lfoot{{\color{gray}IAC--\yearshorthand{\iac@year}--\iac@papernumber}}%
    \cfoot{}%
    \rfoot{{\color{gray}Page \thepage\ of \pageref{LastPage}}}%
}
\pagestyle{fancy}

% Two-column document with single-column title section
\renewcommand\maketitle{\twocolumn[
    \begin{@twocolumnfalse}
        \begingroup
            \global\@topnum\z@   % Prevents figures from going at top of page.
            \@maketitle
            \@thanks
        \endgroup
    \end{@twocolumnfalse}
]}
\def\@maketitle{%

    % Title
    {\centering%

        % IAC edition and paper number
        IAC--\yearshorthand{\iac@year}--\iac@papernumber\par%
        
        \vskip1em

        % Title
        {\bfseries\selectfont \@title \par}%
        
        \vskip 1em%

        % Authors
        \begin{center}%
            \lineskip .5em%
            \newcounter{authnum}%
            \setcounter{authnum}{0}
            \whileboolexpr%
                { test {\ifnumcomp{\value{authnum}}{<}{\theauthcount}} }%
                {%
                    \stepcounter{authnum}%
                    \mbox{
                        \normalsize\textbf{\csuse{iac@author\theauthnum}\textsuperscript{\alph{authnum}}}%
                        \ifboolexpr%
                            { test {\ifnumcomp{\value{authnum}}{=}{\thecontactauthor}}}%
                            {\textsuperscript{\kern-1pt$\conv$}}%
                            {}%
                        \ifboolexpr%
                            { test {\ifnumcomp{\value{authnum}}{<}{\theauthcount}}}%
                            {,~}%
                            {}%
                    }
                }%
        \end{center}%
    }

    % Author affiliations
    {\small\itshape\selectfont%
        \setcounter{authnum}{0}
        \whileboolexpr%
            { test {\ifnumcomp{\value{authnum}}{<}{\theauthcount}} }%
            {%
                \stepcounter{authnum}%
                \parbox{0.75em}{\normalfont\selectfont\textsuperscript{\alph{authnum}}}\csuse{iac@affiliation\theauthnum},~\uline{\csuse{iac@email\theauthnum}}\par
            }%
        \parbox{0.75em}{\normalfont\selectfont\textsuperscript{\kern-1pt$\conv$}}Corresponding author
    }%

    \vskip 1em%
    
    % Abstract
    \indent\iac@abstract\par%
    
    \vskip 4.5ex
}%
