clear all
set more off

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Informática (FI)/Licenciatura en Informática/29. Matemática 4/Trabajos Prácticos/Datos"


*##############################################################################*
								* EJERCICIO 3 *
*##############################################################################*


import excel "META", sheet("META") firstrow clear
describe
keep if (Dias<107 | Dias>163)

regress PrecioUSD Dias, robust
regress PrecioUSD Dias if (Dias<107), robust
regress PrecioUSD Dias if (Dias>163), robust


*##############################################################################*
								* EJERCICIO 5 *
*##############################################################################*


clear all
set obs 15

local vars="y x"

foreach var of local vars {
	generate `var'=.
}

local obs_y="5 10 15 20 25 5 10 15 20 25 5 10 15 20 25"
local obs_x="9.6 20.1 29.9 39.1 50.0 9.6 19.4 29.7 40.3 49.9 10.7 21.3 30.7 41.8 51.2"

local obs: word count `obs_y'

forvalues i=1(1)`obs' {
	foreach var of local vars {
		local `var': word `i' of `obs_`var''
		replace `var'=``var'' in `i'
	}
}

regress `vars', robust
if (e(b)[1,1]>0) display as text "r = " as result sqrt(e(r2))
if (e(b)[1,1]<0) display as text "r = " as result -sqrt(e(r2))


*##############################################################################*
								* EJERCICIO 12 *
*##############################################################################*


clear all
set obs 10

local vars="y x"

foreach var of local vars {
	generate `var'=.
}

local obs_y="15.3 16.8 13.6 13.8 9.8 8.7 5.5 4.7 1.8 1.0"
local obs_x="5 5 10 10 15 15 20 20 25 25"

local obs: word count `obs_y'

forvalues i=1(1)`obs' {
	foreach var of local vars {
		local `var': word `i' of `obs_`var''
		replace `var'=``var'' in `i'
	}
}

regress `vars', robust
predict resid, residuals

local N=e(N)
local df=`N'-2
local conf=0.98
local alpha=1-`conf'
local t=invttail(`df',`alpha'/2)

local b1=_b[x]
local se_b1=sqrt(e(V)[1,1])
local ic_inf_b1=`b1'-`t'*`se_b1'
local ic_sup_b1=`b1'+`t'*`se_b1'
display as text "b1 = " as result `b1'
display as text "t = " as result `t'
display as text "se_b1 = " as result `se_b1'
display as text "IC inferior b1 = " as result `ic_inf_b1'
display as text "IC superior b1 = " as result `ic_sup_b1'

local b0=_b[_cons]
local se_b0=sqrt(e(V)[2,2])
local ic_inf_b0=`b0'-`t'*`se_b0'
local ic_sup_b0=`b0'+`t'*`se_b0'
display as text "b0 = " as result `b0'
display as text "t = " as result `t'
display as text "se_b0 = " as result `se_b0'
display as text "IC inferior b0 = " as result `ic_inf_b0'
display as text "IC superior b0 = " as result `ic_sup_b0'

local conf=0.95
local alpha=1-`conf'
local t=invttail(`df',`alpha'/2)
summarize x
local x_mean=r(mean)
local Sxx=(`N'-1)*r(sd)^2
local x=14
local y=`b0'+`b1'*`x'
generate resid2=resid^2
summarize resid2
local sigma2_est=r(sum)/`df'
local se_y=sqrt(`sigma2_est'*(1/`N'+(`x'-`x_mean')^2/`Sxx'))
local ic_inf_y=`y'-`t'*`se_y'
local ic_sup_y=`y'+`t'*`se_y'
display as text "y = " as result `y'
display as text "t = " as result `t'
display as text "se_y = " as result `se_y'
display as text "IC inferior y = " as result `ic_inf_y'
display as text "IC superior y = " as result `ic_sup_y'


*##############################################################################*
								* EJERCICIO 13 *
*##############################################################################*


clear all
set obs 4

local vars="horas vida_litio vida_alcalina"

foreach var of local vars {
	generate `var'=.
}

local obs_horas="2 1.5 1 0.5"
local obs_vida_litio="3.1 4.2 5.1 6.3"
local obs_vida_alcalina="1.3 1.6 1.8 2.2"

local obs: word count `obs_horas'

forvalues i=1(1)`obs' {
	foreach var of local vars {
		local `var': word `i' of `obs_`var''
		replace `var'=``var'' in `i'
	}
}

foreach var of varlist vida_litio vida_alcalina {

	regress `var' horas, robust
	predict resid_`var', residuals

	local N=e(N)
	local df=`N'-2
	local conf=0.9
	local alpha=1-`conf'
	local t=invttail(`df',`alpha'/2)

	local b0=_b[_cons]
	local b1=_b[horas]
	summarize horas
	local x_mean=r(mean)
	local Sxx=(`N'-1)*r(sd)^2
	local x=1.25
	local y=`b0'+`b1'*`x'
	generate resid2_`var'=resid_`var'^2
	summarize resid2_`var'
	local sigma2_est=r(sum)/`df'
	local se_y=sqrt(`sigma2_est'*(1/`N'+(`x'-`x_mean')^2/`Sxx'))
	local ic_inf_y=`y'-`t'*`se_y'
	local ic_sup_y=`y'+`t'*`se_y'
	display as text "y = " as result `y'
	display as text "t = " as result `t'
	display as text "se_y = " as result `se_y'
	display as text "IC inferior y = " as result `ic_inf_y'
	display as text "IC superior y = " as result `ic_sup_y'

}

generate vida=(vida_litio+vida_alcalina)/2
regress horas vida, robust
regress horas vida_litio vida_alcalina, robust


*##############################################################################*
								* EJERCICIO 14 *
*##############################################################################*


clear all
set obs 10

local vars="y x w z"

foreach var of local vars {
	generate `var'=.
}

local obs_y="440 455 470 510 506 480 460 500 490 450"
local obs_x="50 40 35 45 51 55 53 48 38 44"
local obs_w="105 140 110 130 125 115 100 103 118 98"
local obs_z="75 68 70 64 67 72 70 73 69 74"

local obs: word count `obs_y'

forvalues i=1(1)`obs' {
	foreach var of local vars {
		local `var': word `i' of `obs_`var''
		replace `var'=``var'' in `i'
	}
}

regress `vars', robust


*##############################################################################*
								* EJERCICIO 15 *
*##############################################################################*


clear all
set obs 15

local vars="php algoritmos basededatos programacion"

foreach var of local vars {
	generate `var'=.
}

local obs_php="13 13 13 15 16 15 12 13 13 13 11 14 15 15 15"
local obs_algoritmos="15 14 16 20 18 16 13 16 15 14 12 16 17 19 13"
local obs_basededatos="15 13 13 14 18 17 15 14 14 13 12 11 16 14 15"
local obs_programacion="13 12 14 16 17 15 11 15 13 10 10 14 15 16 10"

local obs: word count `obs_php'

forvalues i=1(1)`obs' {
	foreach var of local vars {
		local `var': word `i' of `obs_`var''
		replace `var'=``var'' in `i'
	}
}

regress `vars', robust