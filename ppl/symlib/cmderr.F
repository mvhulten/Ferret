
	SUBROUTINE CMDERR(IER,LINE,ILEN,IPOS)
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
C      @(#)cmderr.F	1.2    5/26/88
C  
C  
C                                                                      *
C  
C  		    PLOT+ Scientific Graphics System
C  
C                                                                      *
C  
C  
C  	Subprogram called:
C  		CALL CMDERR(IER,LINE,ILEN,IPOS)
C  
C  	Parameters:
C  		IER -- Error code
C  			0 = no error
C  			1 = symbol not found
C  			2 = unmatched single quote in parse
C  			3 = qualifier not found
C  			4 = then missing
C  			5 = nesting error for IF statement
C  			6 = logical operator not found
C  			7 = unmatched double quote in expression
C  			8 = nesting error for WHILE statement
C  			9 = syntax error
C  		       10 = unmatched (in LEV command
C  		       11 = exceeds maximum number of levels
C  		LINE -- Command line
C  		ILEN -- Length of LINE
C  		IPOS -- Position to mark
C  
C  	Description:
C  		Routine to print the input line and point to the
C  		offending element.  This command will abort the
C  		program if BATCHF is true.
C  
C  	History:
C  	    Written: 
C  		5-JAN-86	by Donald W. Denbo
C  	    Modified:
C  
C       11-Dec-2003 ACM Add the string **ERROR before the error message,
C                       to be consistent with Ferret error messages.
C  
C    V6.06 ACM Write error messages to Standard Error, unit number is LERROR
* V72  *acm*  6/17 - Call Ferret's errmsg routine for syntax errors calling 
*                    PPLUS, see ticket 2543

	INCLUDE 'SYSTEM.INC'
	INCLUDE 'CMDCOM.INC'
	INCLUDE 'LUNITS.INC'
	include 'errmsg.parm'

	integer TM_LENSTR1, slen, status
	CHARACTER LINE*(*),frmt*30
	CHARACTER ERRMES(11)*30
	DATA ERRMES/'Symbol not found','Unmatched ''',
     *	'Qualifier not recognized','THEN missing',
     *	'IF levels improperly nested','No operator found',
     *	'Unmatched "','WHILE levels improperly nested',
     *	'Syntax error','Unmatched (','Maximum no. levels exceeded'/

	IF(IER.EQ.0)RETURN
	slen = TM_LENSTR1(ERRMES(IER))
        CALL ERRMSG (ferr_ppl_error, status, ERRMES(IER)(:slen)//' PPLUS '//LINE(:ILEN), *5000)

 5000	RETURN
	END
