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
\DeclareStringOption[english]{language}     % Language
\DeclareBoolOption{unicode}                 % Unicode
\DeclareBoolOption{placeins}                % Prevent floats from skipping sections
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

% Math typesetting
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amstext}
\RequirePackage{amsfonts}
\RequirePackage{bm}

% Math structures
\RequirePackage{array}                                  % Arrays
\RequirePackage{empheq}                                 % Grouped equations
\RequirePackage{amsthm}                                 % Theorems
\RequirePackage{thmtools}                               % List of theorems

% Math and scientific symbols and utilities
\RequirePackage{siunitx}                                % Units
\sisetup{detect-all}
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

% Sections
\titleformat{\section}
    {\normalfont\bfseries}
    {\arabic{section}.~}
    {0pt}
    {#1}
\titleformat{\subsection}
    {\normalfont\itshape}
    {\arabic{section}.\arabic{subsection}~}
    {0pt}
    {#1}
\titleformat{\subsubsection}
    {\normalfont\itshape}
    {\arabic{section}.\arabic{subsection}.\arabic{subsubsection}~}
    {0pt}
    {#1}

% Tables
\newcommand{\thickhline}{%
    \noalign {\ifnum 0=`}\fi \hrule height 2pt
    \futurelet \reserved@a \@xhline
}
\newcolumntype{"}{@{\hskip\tabcolsep\vrule width 1pt\hskip\tabcolsep}}

% Footnotes
\newcommand*{\fnsymbolsingle}[1]{%
    \ensuremath{%
    \ifcase#1%
        \or *%
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

% Equation spacing
\g@addto@macro\normalsize{%
  \setlength\abovedisplayskip{2.5pt}%
  \setlength\belowdisplayskip{7.5pt}%
  \setlength\abovedisplayshortskip{2.5pt}%
  \setlength\belowdisplayshortskip{7.5pt}%
}

%====================================
% 
%            IAC specifics
% 
%====================================

% Author count
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
\renewcommand{\abstract}[1]{\def\iac@abstract{#1}}

% Conference details
\newcommand*{\IACconference}[1]{\def\iac@conference{#1}}\IACconference{}
\newcommand*{\IAClocation}[1]{\def\iac@location{#1}}\IAClocation{}
\newcommand*{\IACdates}[1]{\def\iac@dates{#1}}\IACdates{}
\newcommand*{\IACyear}[1]{\def\iac@year{#1}}\IACyear{}

% Paper details
\newcommand*{\IACpapernumber}[1]{\def\iac@papernumber{#1}}\IACpapernumber{}

% Copyright statement
\newcommand{\IACcopyright}[2]{\def\iac@copyright{Copyright \copyright\,#1 by #2. All rights reserved.}}

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
        \parbox{0.75em}{\textsuperscript{*}}Corresponding author
    }%

    \vskip 1em%
    
    % Abstract
    \indent\iac@abstract\par%
    
    \vskip 4.5ex
}%
