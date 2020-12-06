# proyectos
probando repo
       IDENTIFICATION DIVISION.                                 
                                                                
        PROGRAM-ID PGMCOR06.                                    
      **********************************************************
      *                                                        *
      *  PROGRAMA  05 DE OCTUBRE   2020                        *
      *                                                        *
      *  CORTE DE CONTROL POR SUCURSAL Y TIPO DE CUENTA        *
      *                                                        *
      *  MOSTRAR TOTAL POR TIPO DE CUENTA                      *
      *  MOSTRAR TOTAL POR SUCURSAL                            *
      *  ALU0006.CURSOS.ACTUAL                                 *
      *                                                        *
      **********************************************************
      *                                                        *
      *      MANTENIMIENTO DE PROGRAMA                         *
      **********************************************************
      *  FECHA   *    DETALLE        * COD *                    
      **************************************                    
      *          *                   *     *                    
      *          *                   *     *                    
      *          *                   *     *                    
      *          *                   *     *                    
      *          *                   *     *                    
      **************************************                    
              ENVIRONMENT DIVISION.                           
        INPUT-OUTPUT SECTION.                           
        FILE-CONTROL.                                   
                                                        
              SELECT ENTRADA ASSIGN DDENTRAD            
                     FILE STATUS IS WS-ENT-CODE.        
              SELECT SALIDA ASSIGN DDSALIDA             
                     FILE STATUS IS WS-SAL-CODE.        
                                                        
        DATA DIVISION.                                  
        FILE SECTION.                                   
                                                        
        FD ENTRADA                                      
            BLOCK CONTAINS 0 RECORDS                    
            RECORDING MODE IS F.                        
                                                        
        01 REG-ENTRADA    PIC X(50).                    
                                                        
        FD SALIDA                                       
            BLOCK CONTAINS 0 RECORDS                    
            RECORDING MODE IS F.                        
                                                        
        01 REG-SALIDA     PIC X(50).                    
                                                        
       **************************************           
        WORKING-STORAGE SECTION.                        
               **************************************                          
                                                                       
        77  FILLER        PIC X(26) VALUE '* INICIO WORKING-STORAGE *'.
                                                                       
        77  FILLER        PIC X(26) VALUE '* CODIGOS RETORNO FILES  *'.
                                                                       
        77  WS-ENT-CODE           PIC XX    VALUE SPACES.              
        77  WS-SAL-CODE           PIC XX    VALUE SPACES.              
                                                                       
       **************************************                          
                                                                       
        01  WS-STATUS-LECTURA    PIC X.                                
            88  WS-FIN-LECTURA             VALUE 'Y'.                  
            88  WS-NO-FIN-LECTURA          VALUE 'N'.                  
                                                                       
       **************************************                          
       *LAYOUT CLIENTE CON SALDO ACTUALIZADO*                          
       **************************************                          
        01  WS-REG-ENTRADA.                                            
                                                                       
            03  WS-CLAVE.                                              
                05  WS-SUC-TIP-DOC PIC XX             VALUE SPACES.    
                05  WS-NRO-DOC     PIC 9(11)          VALUE ZEROS.     
            03  WS-CLA-NRO.                                            
                05  WS-SUC         PIC 9(02)          VALUE ZEROS.     
                05  WS-TIPO        PIC 9(02)          VALUE ZEROS.     
                05  WS-NRO         PIC 9(03)          VALUE ZEROS.    
            03  WS-SALDO           PIC -9(09).99      VALUE ZEROS.    
            03  FILLER             PIC X(18)          VALUE SPACES.   
                                                                      
                                                                      
       **************************************                         
       *       LAYOUT SALIDA                *                         
       **************************************                         
        01  WS-REG-SALIDA.                                            
                                                                      
            03  WS-SAL-CLAVE.                                         
                05  WS-SAL-TIP      PIC XX            VALUE SPACES.   
                05  WS-SAL-DOC      PIC 9(11)         VALUE ZEROS.    
            03  FILLER              PIC X(3)          VALUE SPACES.   
            03  WS-SAL-NRO.                                           
                05  WS-SAL-SUC      PIC 9(02)         VALUE ZEROS.    
                05  WS-SAL-TIPO     PIC 9(02)         VALUE ZEROS.    
                05  WS-SAL-NRO1     PIC 9(03)         VALUE ZEROS.    
            03  FILLER              PIC X(5)          VALUE ' ='.     
            03  WS-SAL-SALDO        PIC -ZZZZZZZZ9.99 VALUE ZEROS.    
            03  FILLER              PIC X(10)         VALUE SPACES.   
                                                                      
        01  WS-RESULTADO.                                             
                                                                      
            03  FILLER              PIC X(26)     VALUE               
                       '           TOTAL CUENTA '.                    
            03  WS-TIPO-ANTERIOR    PIC 99        VALUE ZEROS.  
            03  FILLER              PIC X(3)      VALUE ' = '.  
            03  WS-CANT-TIPO        PIC 99        VALUE ZEROS.  
            03  FILLER              PIC X(17)     VALUE SPACES. 
                                                                
        01  WS-SUCURSALES.                                      
            03  FILLER              PIC X(26)     VALUE         
                       '         TOTAL SUCURSAL '.              
            03  WS-SUC-ANTERIOR     PIC 99        VALUE ZEROS.  
            03  FILLER              PIC X(3)      VALUE ' = '.  
            03  WS-CANT-SUC         PIC 99        VALUE ZEROS.  
            03  FILLER              PIC X(17)     VALUE SPACES. 
                                                                
        01  WS-TOTAL-CUE.                                       
                                                                
            03  FILLER              PIC X(26)     VALUE         
                       '       TOTAL DE CUENTAS '.              
            03  WS-TIPO-CUE         PIC 99        VALUE ZEROS.  
            03  FILLER              PIC X(3)      VALUE ' = '.  
            03  WS-TOTAL            PIC 99        VALUE ZEROS.  
            03  FILLER              PIC X(17)     VALUE SPACES. 
                                                                
        01  WS-TOTAL-CUE2.                                      
                                                                
            03  FILLER              PIC X(26)     VALUE         
                       '       TOTAL DE CUENTAS '.                     
            03  WS-TIPO-CUE2        PIC 99        VALUE ZEROS.         
            03  FILLER              PIC X(3)      VALUE ' = '.         
            03  WS-TOTAL2           PIC 99        VALUE ZEROS.         
            03  FILLER              PIC X(17)     VALUE SPACES.        
                                                                       
        01  WS-TOTAL-SUC.                                              
            03  FILLER              PIC X(31)     VALUE                
                       '    TOTAL DE SUCURSALES      = '.              
            03  WS-TOTAL-SUCUR      PIC 99        VALUE 01.            
            03  FILLER              PIC X(17)     VALUE SPACES.        
       ***************************************************************.
        PROCEDURE DIVISION.                                            
       **************************************                          
       *                                    *                          
       *  CUERPO PRINCIPAL DEL PROGRAMA     *                          
       *                                    *                          
       **************************************                          
        MAIN-PROGRAM.                                                  
                                                                       
            PERFORM 1000-INICIO   THRU  F-1000-INICIO.                 
                                                                       
            PERFORM 2000-PROCESO  THRU  F-2000-PROCESO                 
                    UNTIL WS-FIN-LECTURA.                              
            PERFORM 9999-FINAL    THRU  F-9999-FINAL.               
                                                                    
        F-MAIN-PROGRAM. GOBACK.                                     
                                                                    
       **************************************                       
       *                                    *                       
       *  CUERPO INICIO APERTURA ARCHIVOS   *                       
       *                                    *                       
       **************************************                       
        1000-INICIO.                                                
                                                                    
            SET WS-NO-FIN-LECTURA TO TRUE.                          
                                                                    
            OPEN INPUT ENTRADA.                                     
                                                                    
            IF WS-ENT-CODE IS NOT EQUAL '00'                        
               DISPLAY '* ERROR EN OPEN GRABACION= ' WS-ENT-CODE    
               MOVE 9999 TO RETURN-CODE                             
               SET  WS-FIN-LECTURA  TO TRUE                         
            END-IF.                                                 
                                                                    
            OPEN OUTPUT SALIDA.                                     
                                                                    
            IF WS-SAL-CODE IS NOT EQUAL '00'                        
               DISPLAY '* ERROR EN OPEN GRABACION= ' WS-SAL-CODE    
               MOVE 9999 TO RETURN-CODE                           
               SET  WS-FIN-LECTURA  TO TRUE                       
            END-IF.                                               
                                                                  
            PERFORM 2500-LEER-CLIENTE THRU F-2500-LEER-CLIENTE    
            MOVE WS-SUC  TO WS-SUC-ANTERIOR                       
            MOVE WS-TIPO TO WS-TIPO-ANTERIOR                      
            MOVE SPACES  TO WS-REG-SALIDA                         
            WRITE REG-SALIDA FROM WS-REG-SALIDA.                  
                                                                  
        F-1000-INICIO. EXIT.                                      
                                                                  
       **************************************                     
       *                                    *                     
       *  CUERPO PRINCIPAL DE PROCESOS      *                     
       *                                    *                     
       **************************************                     
                                                                  
        2000-PROCESO.                                             
                                                                  
            PERFORM 3000-CORTE THRU F-3000-CORTE.                 
                                                                  
        F-2000-PROCESO. EXIT.                                     
                                                                  
       **************************************                     
       *                                    *                     
       *       LECTURA DE REGISTROS         *                        
       *                                    *                        
       **************************************                        
                                                                     
        2500-LEER-CLIENTE.                                           
                                                                     
            READ ENTRADA INTO WS-REG-ENTRADA                         
            EVALUATE WS-ENT-CODE                                     
            WHEN '00'                                                
                 PERFORM 5000-TOTAL THRU F-5000-TOTAL                
            WHEN '10'                                                
                 SET WS-FIN-LECTURA  TO TRUE                         
            WHEN OTHER                                               
                 DISPLAY '* ERROR EN LECTURA CLIENTE = ' WS-ENT-CODE 
                 MOVE 9999    TO RETURN-CODE                         
                 SET WS-FIN-LECTURA  TO TRUE                         
            END-EVALUATE.                                            
                                                                     
        F-2500-LEER-CLIENTE. EXIT.                                   
                                                                     
       **************************************                        
       *                                    *                        
       *   CC POR SUC Y TIPO DE CUENTA      *                        
       *                                    *                        
       **************************************                        
        3000-CORTE.                                                  
            IF WS-SUC = WS-SUC-ANTERIOR                              
                                                                     
              IF WS-TIPO = WS-TIPO-ANTERIOR                          
                ADD 1 TO WS-CANT-SUC                                 
                ADD 1 TO WS-CANT-TIPO                                
                PERFORM 4000-GRABAR       THRU F-4000-GRABAR         
                PERFORM 2500-LEER-CLIENTE THRU F-2500-LEER-CLIENTE   
                                                                     
              ELSE                                                   
                WRITE REG-SALIDA FROM WS-RESULTADO                   
                MOVE  SPACES TO  WS-REG-SALIDA                       
                WRITE REG-SALIDA FROM WS-REG-SALIDA                  
                IF WS-SAL-CODE   IS NOT EQUAL '00'                   
                   DISPLAY '* ERROR EN WRITE SALIDA1= ' WS-SAL-CODE  
                   MOVE 9999     TO RETURN-CODE                      
                   SET WS-FIN-LECTURA TO TRUE                        
                END-IF                                               
                MOVE 0 TO WS-CANT-TIPO                               
                MOVE WS-TIPO TO WS-TIPO-ANTERIOR                     
              END-IF                                                 
                                                                     
            ELSE                                                     
                WRITE REG-SALIDA FROM WS-RESULTADO                   
                MOVE  SPACES     TO WS-REG-SALIDA                    
                WRITE REG-SALIDA FROM WS-REG-SALIDA                  
                WRITE REG-SALIDA FROM WS-SUCURSALES                  
                MOVE '-------------------------------' TO WS-REG-SALIDA
                WRITE REG-SALIDA FROM WS-REG-SALIDA                    
                MOVE  SPACES     TO WS-REG-SALIDA                      
                WRITE REG-SALIDA FROM WS-REG-SALIDA                    
                IF WS-SAL-CODE   IS NOT EQUAL '00'                     
                   DISPLAY '* ERROR EN WRITE SALIDA3= ' WS-SAL-CODE    
                   MOVE 9999     TO RETURN-CODE                        
                   SET WS-FIN-LECTURA TO TRUE                          
                END-IF                                                 
                ADD  1 TO WS-TOTAL-SUCUR                               
                MOVE 0 TO WS-CANT-TIPO                                 
                MOVE WS-TIPO TO WS-TIPO-ANTERIOR                       
                MOVE 0 TO WS-CANT-SUC                                  
                MOVE WS-SUC TO WS-SUC-ANTERIOR                         
            END-IF.                                                    
        F-3000-CORTE.  EXIT.                                           
                                                                       
        4000-GRABAR.                                                   
                                                                       
            MOVE WS-CLAVE    TO WS-SAL-CLAVE                           
            MOVE WS-CLA-NRO  TO WS-SAL-NRO                             
            MOVE WS-SALDO    TO WS-SAL-SALDO                           
            WRITE REG-SALIDA FROM WS-REG-SALIDA                        
            IF  WS-SAL-CODE  IS NOT EQUAL '00'                         
                 DISPLAY '* ERROR EN WRITE SALIDA4= ' WS-SAL-CODE      
                 MOVE 9999   TO RETURN-CODE                            
                 SET WS-FIN-LECTURA TO TRUE           
            END-IF.                                   
                                                      
        F-4000-GRABAR.  EXIT.                         
                                                      
        5000-TOTAL.                                   
            IF WS-TIPO = 01                           
              MOVE WS-TIPO TO WS-TIPO-CUE             
              ADD 1 TO WS-TOTAL                       
            ELSE IF WS-TIPO = 02                      
              MOVE WS-TIPO TO WS-TIPO-CUE2            
              ADD 1 TO WS-TOTAL2                      
            END-IF END-IF.                            
        F-5000-TOTAL.  EXIT.                          
                                                      
       **************************************         
       *                                    *         
       *  CUERPO FINAL CIERRE DE FILES      *         
       *                                    *         
       **************************************         
                                                      
        9999-FINAL.                                   
                                                      
            WRITE REG-SALIDA  FROM WS-RESULTADO       
            MOVE  SPACES      TO   WS-REG-SALIDA      
            WRITE REG-SALIDA  FROM WS-REG-SALIDA      
            WRITE REG-SALIDA  FROM WS-SUCURSALES                    
            MOVE  SPACES      TO   WS-REG-SALIDA                    
            WRITE REG-SALIDA  FROM WS-REG-SALIDA                    
               IF WS-SAL-CODE IS NOT EQUAL '00'                     
                   DISPLAY '* ERROR EN WRITE SALIDA5= ' WS-SAL-CODE 
                   MOVE 9999  TO RETURN-CODE                        
                   SET WS-FIN-LECTURA TO TRUE                       
               END-IF.                                              
                                                                    
            WRITE REG-SALIDA  FROM WS-TOTAL-CUE                     
            WRITE REG-SALIDA  FROM WS-TOTAL-CUE2                    
            WRITE REG-SALIDA  FROM WS-TOTAL-SUC                     
               IF WS-SAL-CODE IS NOT EQUAL '00'                     
                   DISPLAY '* ERROR EN WRITE SALIDA5= ' WS-SAL-CODE 
                   MOVE 9999  TO RETURN-CODE                        
                   SET WS-FIN-LECTURA TO TRUE                       
               END-IF.                                              
                                                                    
            CLOSE ENTRADA                                           
               IF WS-ENT-CODE IS NOT EQUAL '00'                     
                 DISPLAY '* ERROR EN CLOSE GRABACION= ' WS-ENT-CODE 
                 MOVE 9999   TO RETURN-CODE                         
                 SET WS-FIN-LECTURA TO TRUE                         
               END-IF.                                              
                                                                    
            CLOSE SALIDA                                           
               IF WS-SAL-CODE IS NOT EQUAL '00'                    
                 DISPLAY '* ERROR EN CLOSE GRABACION= ' WS-SAL-CODE
                 MOVE 9999   TO RETURN-CODE                        
                 SET WS-FIN-LECTURA TO TRUE                        
               END-IF.                                             
                                                                   
        F-9999-FINAL.  EXIT.                                       
                                                                         
