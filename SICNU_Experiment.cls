% ============================================================
% SICNU Experiment Template
% Experiment.cls
% ============================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{SICNU_Experiment}[2026/09/24 SICNU Experiment Template]


% ============================================================
% Base class
% ============================================================

\LoadClass{ctexart}
\ctexset{
  part ={name = {,、},aftername = {},format = \zihao{-2}\bfseries\raggedright,afterskip = 0pt},
  section = {name = {,、},nameformat = \Large\bfseries\raggedright,aftername = {},titleformat = \normalsize\bfseries\raggedright}
}
%=============================================================


\RequirePackage{chngcntr}
\counterwithin*{section}{part}



%===========================================================









% ==========================================================
% 实验报告信息
% ==========================================================

\RequirePackage{expl3}
\RequirePackage{xparse}
\RequirePackage{tikz}
\RequirePackage{pdfpages}

% ==========================================================
% LaTeX3
% ==========================================================

\ExplSyntaxOn


% ----------------------------------------------------------
% 数据变量
% ----------------------------------------------------------

\tl_new:N \g__labreport_student_name_tl
\tl_new:N \g__labreport_student_id_tl
\tl_new:N \g__labreport_college_tl
\tl_new:N \g__labreport_grade_tl
\tl_new:N \g__labreport_class_tl
\tl_new:N \g__labreport_group_number_tl
\tl_new:N \g__labreport_teacher_tl
\tl_new:N \g__labreport_experiment_name_tl
\tl_new:N \g__labreport_experiment_date_tl
\tl_new:N \g__labreport_weekday_tl

% 日期拆分
\tl_new:N \g__labreport_date_year_tl
\tl_new:N \g__labreport_date_month_tl
\tl_new:N \g__labreport_date_day_tl

\seq_new:N \l__labreport_date_seq


% ----------------------------------------------------------
% 默认值
% ----------------------------------------------------------

\tl_gset:Nn \g__labreport_student_name_tl       {}
\tl_gset:Nn \g__labreport_student_id_tl         {}
\tl_gset:Nn \g__labreport_college_tl            {}
\tl_gset:Nn \g__labreport_grade_tl              {}
\tl_gset:Nn \g__labreport_class_tl              {}
\tl_gset:Nn \g__labreport_group_number_tl       {}
\tl_gset:Nn \g__labreport_teacher_tl            {}
\tl_gset:Nn \g__labreport_experiment_name_tl    {}
\tl_gset:Nn \g__labreport_experiment_date_tl    {}
\tl_gset:Nn \g__labreport_weekday_tl            {}

\tl_gset:Nn \g__labreport_date_year_tl          {}
\tl_gset:Nn \g__labreport_date_month_tl         {}
\tl_gset:Nn \g__labreport_date_day_tl           {}


% ----------------------------------------------------------
% 日期处理
%
% 用户输入：
%   experiment-date = {2026-09-24}
%
% 自动拆分为：
%   2026
%   09
%   24
% ----------------------------------------------------------

\cs_new_protected:Npn \__labreport_set_date:n #1
  {
    \tl_gset:Nn
      \g__labreport_experiment_date_tl
      {#1}

    \seq_set_split:Nnn
      \l__labreport_date_seq
      {-}
      {#1}

    \tl_gset:Nx
      \g__labreport_date_year_tl
      {
        \seq_item:Nn
          \l__labreport_date_seq
          {1}
      }

    \tl_gset:Nx
      \g__labreport_date_month_tl
      {
        \seq_item:Nn
          \l__labreport_date_seq
          {2}
      }

    \tl_gset:Nx
      \g__labreport_date_day_tl
      {
        \seq_item:Nn
          \l__labreport_date_seq
          {3}
      }
  }


% ----------------------------------------------------------
% Key-Value
% ----------------------------------------------------------

\keys_define:nn { labreport }
  {
    student-name
      .tl_gset:N = \g__labreport_student_name_tl,

    student-id
      .tl_gset:N = \g__labreport_student_id_tl,

    college
      .tl_gset:N = \g__labreport_college_tl,

    grade
      .tl_gset:N = \g__labreport_grade_tl,

    class
      .tl_gset:N = \g__labreport_class_tl,

    group-number
      .tl_gset:N = \g__labreport_group_number_tl,

    teacher
      .tl_gset:N = \g__labreport_teacher_tl,

    experiment-name
      .tl_gset:N = \g__labreport_experiment_name_tl,

    experiment-date
      .code:n =
        {
          \__labreport_set_date:n {#1}
        },

    weekday
      .tl_gset:N = \g__labreport_weekday_tl,
  }


% ----------------------------------------------------------
% 用户接口
% ----------------------------------------------------------

\NewDocumentCommand \reportsetup { m }
  {
    \keys_set:nn
      { labreport }
      { #1 }
  }


% ----------------------------------------------------------
% 给普通 LaTeX / TikZ 使用的接口
% ----------------------------------------------------------

\cs_new:Npn \LabReportStudentName
  {
    \tl_use:N \g__labreport_student_name_tl
  }

\cs_new:Npn \LabReportStudentID
  {
    \tl_use:N \g__labreport_student_id_tl
  }

\cs_new:Npn \LabReportCollege
  {
    \tl_use:N \g__labreport_college_tl
  }

\cs_new:Npn \LabReportGrade
  {
    \tl_use:N \g__labreport_grade_tl
  }

\cs_new:Npn \LabReportClass
  {
    \tl_use:N \g__labreport_class_tl
  }

\cs_new:Npn \LabReportGroupNumber
  {
    \tl_use:N \g__labreport_group_number_tl
  }

\cs_new:Npn \LabReportTeacher
  {
    \tl_use:N \g__labreport_teacher_tl
  }

\cs_new:Npn \LabReportExperimentName
  {
    \tl_use:N \g__labreport_experiment_name_tl
  }

\cs_new:Npn \LabReportDateYear
  {
    \tl_use:N \g__labreport_date_year_tl
  }

\cs_new:Npn \LabReportDateMonth
  {
    \tl_use:N \g__labreport_date_month_tl
  }

\cs_new:Npn \LabReportDateDay
  {
    \tl_use:N \g__labreport_date_day_tl
  }

\cs_new:Npn \LabReportWeekday
  {
    \tl_use:N \g__labreport_weekday_tl
  }


\ExplSyntaxOff


% ==========================================================
% PDF 封面
%
% 注意：
% TikZ 必须放在 \ExplSyntaxOff 之后，
% 否则 "remember picture" 会被读成 "rememberpicture"。
% ==========================================================

\newcommand{\LabReportCoverOverlay}{%
  \begin{tikzpicture}[
    remember picture,
    overlay,
    shift={(current page.north west)},
    font=\Large
  ]

    % ------------------------------------------------------
    % 实验名称
    % ------------------------------------------------------

    \node[
      anchor=west,text width=8.6cm
    ] at (1.4,-6.15)
    {
      \LabReportExperimentName
    };


    % ------------------------------------------------------
    % 姓名
    % ------------------------------------------------------

    \node at (13.7,-5)
    {
      \LabReportStudentName
    };


    % ------------------------------------------------------
    % 学号
    % ------------------------------------------------------

    \node at (18.2,-5)
    {
      \LabReportStudentID
    };


    % ------------------------------------------------------
    % 学院
    % ------------------------------------------------------

    \node at (13.7,-6.25)
    {
      \LabReportCollege
    };


    % ------------------------------------------------------
    % 年级
    % ------------------------------------------------------

    \node at (18.2,-6.25)
    {
      \LabReportGrade
    };


    % ------------------------------------------------------
    % 班级
    % ------------------------------------------------------

    \node at (13.7,-7.5)
    {
      \LabReportClass
    };


    % ------------------------------------------------------
    % 小组序号
    % ------------------------------------------------------

    \node at (16.7,-7.5)
    {
      \LabReportGroupNumber
    };


    % ------------------------------------------------------
    % 指导老师
    % ------------------------------------------------------

    \node at (14.7,-8.75)
    {
      \LabReportTeacher
    };


    % ------------------------------------------------------
    % 年
    % ------------------------------------------------------

    \node[font=\large] at (13.53,-9.71)
    {
      \LabReportDateYear
    };


    % ------------------------------------------------------
    % 月
    % ------------------------------------------------------

    \node[font=\large] at (14.98,-9.71)
    {
      \LabReportDateMonth
    };


    % ------------------------------------------------------
    % 日
    % ------------------------------------------------------

    \node[font=\large] at (16.45,-9.71)
    {
      \LabReportDateDay
    };


    % ------------------------------------------------------
    % 星期
    % ------------------------------------------------------

    \node[font=\large] at (19.08,-9.71)
    {
      \LabReportWeekday
    };

  \end{tikzpicture}%
}


% ==========================================================
% 生成封面
% ==========================================================

\newcommand{\makecover}{%
      \AddToHookNext{shipout/background}{%
        \put(0,-\paperheight){%
        \includegraphics[
      width=\paperwidth,
      height=\paperheight
    ]{background.pdf}%
  }%
}
      \thispagestyle{empty}%
      \setcounter{part}{1}%
      \afterpage{\aftergroup\restoregeometry}
      \LabReportCoverOverlay
}
%============================================================





% ============================================================
% Required packages
% ============================================================

\RequirePackage{geometry}
\RequirePackage{fancyhdr}


% ============================================================
% Page layout
% ============================================================

\geometry{
  a4paper,
  left=15mm,
  right=15mm,
  top=6mm,
  bottom=2.2mm,
  includehead,
  includefoot
}


% ============================================================
% Page border parameters
% ============================================================

\makeatletter

% Distance from paper edge to border
\newdimen\@bordertop
\newdimen\@borderbottom
\newdimen\@borderleft
\newdimen\@borderright

% Border line width
\newdimen\@borderwidth

% Default values
\@bordertop=10mm
\@borderbottom=10mm
\@borderleft=10mm
\@borderright=10mm
\@borderwidth=2pt





% ============================================================
% User interfaces
% ============================================================

% Distance from top edge
\newcommand{\bordertop}[1]{%
  \@bordertop=#1\relax
}

% Distance from bottom edge
\newcommand{\borderbottom}[1]{%
  \@borderbottom=#1\relax
}

% Distance from left edge
\newcommand{\borderleft}[1]{%
  \@borderleft=#1\relax
}

% Distance from right edge
\newcommand{\borderright}[1]{%
  \@borderright=#1\relax
}

% Border line width
\newcommand{\borderwidth}[1]{%
  \@borderwidth=#1\relax
}


% ============================================================
% Draw page border
% ============================================================

\newcommand{\@drawpageborder}{%
  \begin{tikzpicture}[remember picture,overlay]
    \draw[
      line width=\@borderwidth
    ]
      ([xshift=\@borderleft,yshift=-\@bordertop]current page.north west)
      rectangle
      ([xshift=-\@borderright,yshift=\@borderbottom]current page.south east);
  \end{tikzpicture}%
}


% ============================================================
% Draw border on every page
% ============================================================

\AddToHook{shipout/background}{%
  \@drawpageborder
}


% ============================================================
% Page style
% ============================================================

\pagestyle{fancy}

\fancyhf{}

% Page number
\fancyfoot[C]{\thepage}

% Remove header/footer rules
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}


% Avoid fancyhdr warnings
\setlength{\headheight}{0pt}


% ============================================================
% Default paragraph settings
% ============================================================

\setlength{\parindent}{2em}
\setlength{\parskip}{0pt}


% ============================================================
% End
% ============================================================

\makeatother

%===========================================================
% 文档开始时，先把第一页切换到特殊布局
\AtBeginDocument{%
  \newgeometry{
  a4paper,
  left=15mm,
  right=15mm,
  top=13.8cm,
  bottom=2.2mm,
  includefoot
}
\AddToHookNext{shipout/after}{%
  \afterpage{\aftergroup\restoregeometry}
}
}


%===========================================================