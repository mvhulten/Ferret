	INTEGER FUNCTION TM_GET_GRIDNUM (user_grid)
*
*
*  This software was developed by the Thermal Modeling and Analysis
*  Project(TMAP) of the National Oceanographic and Atmospheric
*  Administration's (NOAA) Pacific Marine Environmental Lab(PMEL),
*  hereafter referred to as NOAA/PMEL/TMAP.
*
*  Access and use of this software shall impose the following
*  obligations and understandings on the user. The user is granted the
*  right, without any fee or cost, to use, copy, modify, alter, enhance
*  and distribute this software, and any derivative works thereof, and
*  its supporting documentation for any purpose whatsoever, provided
*  that this entire notice appears in all copies of the software,
*  derivative works and supporting documentation.  Further, the user
*  agrees to credit NOAA/PMEL/TMAP in any publications that result from
*  the use of this software or in any product that includes this
*  software. The names TMAP, NOAA and/or PMEL, however, may not be used
*  in any advertising or publicity to endorse or promote any products
*  or commercial entity unless specific written permission is obtained
*  from NOAA/PMEL/TMAP. The user also understands that NOAA/PMEL/TMAP
*  is not obligated to provide the user with any support, consulting,
*  training or assistance of any kind with regard to the use, operation
*  and performance of this software nor to provide the user with any
*  updates, revisions, new versions or "bug fixes".
*
*  THIS SOFTWARE IS PROVIDED BY NOAA/PMEL/TMAP "AS IS" AND ANY EXPRESS
*  OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
*  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
*  ARE DISCLAIMED. IN NO EVENT SHALL NOAA/PMEL/TMAP BE LIABLE FOR ANY SPECIAL,
*  INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER
*  RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF
*  CONTRACT, NEGLIGENCE OR OTHER TORTUOUS ACTION, ARISING OUT OF OR IN
*  CONNECTION WITH THE ACCESS, USE OR PERFORMANCE OF THIS SOFTWARE. 
*
*
* Searches the list of predefined and user-defined grid_names and returns the
* number associated with the grid_name given by the user. If no match is found
* the value unspecified_int4 is returned.
*
* written 11/86 By M. Verschell for PMEL/TMAP
*
* revision 0.01 - 08/17/88 - changed name from GT_GET_GRIDNUM
*
* *kob* 10/96 	- Linux port.  Linux didn't like tabs between "include"
*	          and what was being included.  removed them
* V510 *sh* 4/00 - conversion to dynamic grids and axes -- check 'em
* V6.74 3/12 *acm* cleanup ifdefs and unnecessary include files

# include "tmap_dset.parm"	
	include 'tmap_dims.parm'	! 
#include "gt_lib.parm"
	include 'xtm_grid.cmn_text'	! pre-defined grid common
	external xgt_grid_data

	CHARACTER*(*)	user_grid
	INTEGER*4	ngrid, istat
	INTEGER*4	STR_CASE_BLIND_COMPARE

* check the static grids
	DO 100 ngrid=1,max_grids
	  istat = STR_CASE_BLIND_COMPARE(grid_name(ngrid),user_grid)
	  IF (istat .EQ. str_match) THEN
	    TM_GET_GRIDNUM = ngrid
	    GOTO 900
	  ENDIF
 100	CONTINUE

* check the dynamic grids
	ngrid = 0
 200	CALL TM_NEXT_DYN_GRID( ngrid, *299)
	  istat = STR_CASE_BLIND_COMPARE(grid_name(ngrid),user_grid)
	  IF (istat .EQ. str_match) THEN
	    TM_GET_GRIDNUM = ngrid
	    GOTO 900
	  ENDIF
	GOTO 200

* not found
 299	TM_GET_GRIDNUM = unspecified_int4

* found
 900	RETURN
	END
