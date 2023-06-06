strlen:
    xor rax, rax
    
loop_align:
	mov cl,[rdi]
    test rdi, 0x7
    jz strlenheader //Jump if Memory Adress Aligned
    cmp cl,0  
    je .Lend //Jump if Null-Byte found
    inc rdi
    inc rax
    jmp loop_align
	
strlenheader:
	mov r10, 0x7F7F7F7F7F7F7F7F 
    mov r8, 0xffffffffffffffff
char_loop:
    mov rcx, [rdi]
    mov rdx, rcx
    and rcx, r10    //Bithack inspired by: "https://graphics.stanford.edu/~seander/bithacks.html#ZeroInWord" 
    add rcx, r10    
    or rcx, rdx             
    or rcx, r10    

    cmp rcx, r8
    jne scalar_len //jump if Null-Byte found
      
    add rax, 8
    add rdi, 8
    jmp char_loop
    
scalar_len: //Skalare Implementierung strlen
    mov cl,[rdi]
    cmp cl,0                    
    je .Lend
    inc rdi
    inc rax
    jmp scalar_len
.Lend:
    ret
