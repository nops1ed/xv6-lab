
user/_find：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmt>:

static int __FOUND_ = 0;
//remain Old C style
char*
fmt(char *path)
{
   0:	1101                	add	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	add	s0,sp,32
   c:	84aa                	mv	s1,a0
   char *buf = (char *)malloc(sizeof(char) * (DIRSIZ + 1));
   e:	453d                	li	a0,15
  10:	00001097          	auipc	ra,0x1
  14:	9a2080e7          	jalr	-1630(ra) # 9b2 <malloc>
  18:	892a                	mv	s2,a0
   char *p;
   
     // Find first character after last slash.
   for(p=path+strlen(path); p >= path && *p != '/'; p--)
  1a:	8526                	mv	a0,s1
  1c:	00000097          	auipc	ra,0x0
  20:	352080e7          	jalr	850(ra) # 36e <strlen>
  24:	02051593          	sll	a1,a0,0x20
  28:	9181                	srl	a1,a1,0x20
  2a:	95a6                	add	a1,a1,s1
  2c:	02f00713          	li	a4,47
  30:	0095e963          	bltu	a1,s1,42 <fmt+0x42>
  34:	0005c783          	lbu	a5,0(a1)
  38:	00e78563          	beq	a5,a4,42 <fmt+0x42>
  3c:	15fd                	add	a1,a1,-1
  3e:	fe95fbe3          	bgeu	a1,s1,34 <fmt+0x34>
       ;
    p++;
  42:	00158493          	add	s1,a1,1
   
     // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  46:	8526                	mv	a0,s1
  48:	00000097          	auipc	ra,0x0
  4c:	326080e7          	jalr	806(ra) # 36e <strlen>
  50:	0005079b          	sext.w	a5,a0
  54:	4735                	li	a4,13
  56:	00f77963          	bgeu	a4,a5,68 <fmt+0x68>
    return p;
  memmove(buf, p, strlen(p));
  //memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  5a:	8526                	mv	a0,s1
  5c:	60e2                	ld	ra,24(sp)
  5e:	6442                	ld	s0,16(sp)
  60:	64a2                	ld	s1,8(sp)
  62:	6902                	ld	s2,0(sp)
  64:	6105                	add	sp,sp,32
  66:	8082                	ret
  memmove(buf, p, strlen(p));
  68:	8526                	mv	a0,s1
  6a:	00000097          	auipc	ra,0x0
  6e:	304080e7          	jalr	772(ra) # 36e <strlen>
  72:	0005061b          	sext.w	a2,a0
  76:	85a6                	mv	a1,s1
  78:	854a                	mv	a0,s2
  7a:	00000097          	auipc	ra,0x0
  7e:	466080e7          	jalr	1126(ra) # 4e0 <memmove>
  return buf;
  82:	84ca                	mv	s1,s2
  84:	bfd9                	j	5a <fmt+0x5a>

0000000000000086 <find>:

//find function should be recursive
//filename indicates the file we wanna find
void 
find (char *path , char *filename) 
{
  86:	d9010113          	add	sp,sp,-624
  8a:	26113423          	sd	ra,616(sp)
  8e:	26813023          	sd	s0,608(sp)
  92:	24913c23          	sd	s1,600(sp)
  96:	25213823          	sd	s2,592(sp)
  9a:	25313423          	sd	s3,584(sp)
  9e:	25413023          	sd	s4,576(sp)
  a2:	23513c23          	sd	s5,568(sp)
  a6:	23613823          	sd	s6,560(sp)
  aa:	1c80                	add	s0,sp,624
  ac:	892a                	mv	s2,a0
  ae:	89ae                	mv	s3,a1
  int fd;
  //describe current node stat
  struct stat st;
  struct dirent de;
  
  if ((fd = open(path , O_RDONLY)) < 0)
  b0:	4581                	li	a1,0
  b2:	00000097          	auipc	ra,0x0
  b6:	520080e7          	jalr	1312(ra) # 5d2 <open>
  ba:	0e054e63          	bltz	a0,1b6 <find+0x130>
  be:	84aa                	mv	s1,a0
    //send error message to standard error stream
    fprintf(2 , "find: cannot open %s\n" , path);
    return;
  }
  
  if (fstat(fd , &st) < 0)
  c0:	da840593          	add	a1,s0,-600
  c4:	00000097          	auipc	ra,0x0
  c8:	526080e7          	jalr	1318(ra) # 5ea <fstat>
  cc:	10054063          	bltz	a0,1cc <find+0x146>
    return ;
  }
      //You need to call find again & its para should be all files
      //Below current file
      //TODO:implement recursive
  if (strlen(path) + 1 + DIRSIZ + 1 > sizeof(buf))  
  d0:	854a                	mv	a0,s2
  d2:	00000097          	auipc	ra,0x0
  d6:	29c080e7          	jalr	668(ra) # 36e <strlen>
  da:	2541                	addw	a0,a0,16
  dc:	20000793          	li	a5,512
  e0:	10a7e663          	bltu	a5,a0,1ec <find+0x166>
  {
    printf("find: path too long\n");
    close(fd);
    return;
  }
  strcpy(buf , path);
  e4:	85ca                	mv	a1,s2
  e6:	dc040513          	add	a0,s0,-576
  ea:	00000097          	auipc	ra,0x0
  ee:	23c080e7          	jalr	572(ra) # 326 <strcpy>
  //locate the end of buffer
  p = buf + strlen(buf);
  f2:	dc040513          	add	a0,s0,-576
  f6:	00000097          	auipc	ra,0x0
  fa:	278080e7          	jalr	632(ra) # 36e <strlen>
  fe:	1502                	sll	a0,a0,0x20
 100:	9101                	srl	a0,a0,0x20
 102:	dc040793          	add	a5,s0,-576
 106:	00a78933          	add	s2,a5,a0
  *p++ = '/';
 10a:	00190a13          	add	s4,s2,1
 10e:	02f00793          	li	a5,47
 112:	00f90023          	sb	a5,0(s2)
    if (stat(buf , &st) < 0)
    {
      printf("find: cannot stat %s\n" , buf);
      continue;
    }
    switch(st.type)
 116:	4b05                	li	s6,1
 118:	4a89                	li	s5,2
  while(read(fd , &de , sizeof(de)) == sizeof(de))
 11a:	4641                	li	a2,16
 11c:	d9840593          	add	a1,s0,-616
 120:	8526                	mv	a0,s1
 122:	00000097          	auipc	ra,0x0
 126:	488080e7          	jalr	1160(ra) # 5aa <read>
 12a:	47c1                	li	a5,16
 12c:	12f51963          	bne	a0,a5,25e <find+0x1d8>
    if (de.inum == 0)
 130:	d9845783          	lhu	a5,-616(s0)
 134:	d3fd                	beqz	a5,11a <find+0x94>
    memmove(p , de.name , DIRSIZ);
 136:	4639                	li	a2,14
 138:	d9a40593          	add	a1,s0,-614
 13c:	8552                	mv	a0,s4
 13e:	00000097          	auipc	ra,0x0
 142:	3a2080e7          	jalr	930(ra) # 4e0 <memmove>
    p[DIRSIZ] = 0;
 146:	000907a3          	sb	zero,15(s2)
    if (stat(buf , &st) < 0)
 14a:	da840593          	add	a1,s0,-600
 14e:	dc040513          	add	a0,s0,-576
 152:	00000097          	auipc	ra,0x0
 156:	300080e7          	jalr	768(ra) # 452 <stat>
 15a:	0a054763          	bltz	a0,208 <find+0x182>
    switch(st.type)
 15e:	db041783          	lh	a5,-592(s0)
 162:	0b678e63          	beq	a5,s6,21e <find+0x198>
 166:	fb579ae3          	bne	a5,s5,11a <find+0x94>
        //printf("Here we find some file %s\n" , fmt(buf));
        //printf("And Im finding file: !%s!\n" , filename);
        //printf("File find :%s! size = %d , filename_size = %d\n" , fmt(buf) , sizeof(fmt(buf)) , sizeof(filename));
        //printf("I wanna find !%s! , now we got !%s!\n" , filename, fmt(buf));
        //printf("The strcmp returns: %d\n" , strcmp(fmt(buf) , filename) );
        if (strcmp(filename , "") == 0 || strcmp(fmt(buf) , filename) == 0)
 16a:	00001597          	auipc	a1,0x1
 16e:	97e58593          	add	a1,a1,-1666 # ae8 <malloc+0x136>
 172:	854e                	mv	a0,s3
 174:	00000097          	auipc	ra,0x0
 178:	1ce080e7          	jalr	462(ra) # 342 <strcmp>
 17c:	cd09                	beqz	a0,196 <find+0x110>
 17e:	dc040513          	add	a0,s0,-576
 182:	00000097          	auipc	ra,0x0
 186:	e7e080e7          	jalr	-386(ra) # 0 <fmt>
 18a:	85ce                	mv	a1,s3
 18c:	00000097          	auipc	ra,0x0
 190:	1b6080e7          	jalr	438(ra) # 342 <strcmp>
 194:	f159                	bnez	a0,11a <find+0x94>
        //stupid gcc
        {
          __FOUND_ = 1;
 196:	4785                	li	a5,1
 198:	00001717          	auipc	a4,0x1
 19c:	e6f72423          	sw	a5,-408(a4) # 1000 <__FOUND_>
          printf("%s\n" , buf);
 1a0:	dc040593          	add	a1,s0,-576
 1a4:	00001517          	auipc	a0,0x1
 1a8:	94c50513          	add	a0,a0,-1716 # af0 <malloc+0x13e>
 1ac:	00000097          	auipc	ra,0x0
 1b0:	74e080e7          	jalr	1870(ra) # 8fa <printf>
 1b4:	b79d                	j	11a <find+0x94>
    fprintf(2 , "find: cannot open %s\n" , path);
 1b6:	864a                	mv	a2,s2
 1b8:	00001597          	auipc	a1,0x1
 1bc:	8e858593          	add	a1,a1,-1816 # aa0 <malloc+0xee>
 1c0:	4509                	li	a0,2
 1c2:	00000097          	auipc	ra,0x0
 1c6:	70a080e7          	jalr	1802(ra) # 8cc <fprintf>
    return;
 1ca:	a879                	j	268 <find+0x1e2>
    fprintf(2 , "find: cannot stat %s\n" , path);
 1cc:	864a                	mv	a2,s2
 1ce:	00001597          	auipc	a1,0x1
 1d2:	8ea58593          	add	a1,a1,-1814 # ab8 <malloc+0x106>
 1d6:	4509                	li	a0,2
 1d8:	00000097          	auipc	ra,0x0
 1dc:	6f4080e7          	jalr	1780(ra) # 8cc <fprintf>
    close(fd);
 1e0:	8526                	mv	a0,s1
 1e2:	00000097          	auipc	ra,0x0
 1e6:	3d8080e7          	jalr	984(ra) # 5ba <close>
    return ;
 1ea:	a8bd                	j	268 <find+0x1e2>
    printf("find: path too long\n");
 1ec:	00001517          	auipc	a0,0x1
 1f0:	8e450513          	add	a0,a0,-1820 # ad0 <malloc+0x11e>
 1f4:	00000097          	auipc	ra,0x0
 1f8:	706080e7          	jalr	1798(ra) # 8fa <printf>
    close(fd);
 1fc:	8526                	mv	a0,s1
 1fe:	00000097          	auipc	ra,0x0
 202:	3bc080e7          	jalr	956(ra) # 5ba <close>
    return;
 206:	a08d                	j	268 <find+0x1e2>
      printf("find: cannot stat %s\n" , buf);
 208:	dc040593          	add	a1,s0,-576
 20c:	00001517          	auipc	a0,0x1
 210:	8ac50513          	add	a0,a0,-1876 # ab8 <malloc+0x106>
 214:	00000097          	auipc	ra,0x0
 218:	6e6080e7          	jalr	1766(ra) # 8fa <printf>
      continue;
 21c:	bdfd                	j	11a <find+0x94>
        }
        continue;
      case T_DIR:
      {
        if (!strcmp(de.name , ".") || !strcmp(de.name , ".."))
 21e:	00001597          	auipc	a1,0x1
 222:	8da58593          	add	a1,a1,-1830 # af8 <malloc+0x146>
 226:	d9a40513          	add	a0,s0,-614
 22a:	00000097          	auipc	ra,0x0
 22e:	118080e7          	jalr	280(ra) # 342 <strcmp>
 232:	ee0504e3          	beqz	a0,11a <find+0x94>
 236:	00001597          	auipc	a1,0x1
 23a:	8ca58593          	add	a1,a1,-1846 # b00 <malloc+0x14e>
 23e:	d9a40513          	add	a0,s0,-614
 242:	00000097          	auipc	ra,0x0
 246:	100080e7          	jalr	256(ra) # 342 <strcmp>
 24a:	ec0508e3          	beqz	a0,11a <find+0x94>
        //memmove(buf_new + strlen(buf) + 1, de.name , strlen(de.name));
        //p = buf + sizeof(buf);
        //printf("p point to %c\n"  , *(p - 1));
        //*p++ = '/';
        //printf("And i pass %s\n" , buf_new);
        find(buf, filename);
 24e:	85ce                	mv	a1,s3
 250:	dc040513          	add	a0,s0,-576
 254:	00000097          	auipc	ra,0x0
 258:	e32080e7          	jalr	-462(ra) # 86 <find>
 25c:	bd7d                	j	11a <find+0x94>
      }
      case T_DEVICE:
    }
  }
  close(fd);
 25e:	8526                	mv	a0,s1
 260:	00000097          	auipc	ra,0x0
 264:	35a080e7          	jalr	858(ra) # 5ba <close>
  return ;
}
 268:	26813083          	ld	ra,616(sp)
 26c:	26013403          	ld	s0,608(sp)
 270:	25813483          	ld	s1,600(sp)
 274:	25013903          	ld	s2,592(sp)
 278:	24813983          	ld	s3,584(sp)
 27c:	24013a03          	ld	s4,576(sp)
 280:	23813a83          	ld	s5,568(sp)
 284:	23013b03          	ld	s6,560(sp)
 288:	27010113          	add	sp,sp,624
 28c:	8082                	ret

000000000000028e <main>:

int 
main(int argc ,char *argv[])
{
 28e:	1141                	add	sp,sp,-16
 290:	e406                	sd	ra,8(sp)
 292:	e022                	sd	s0,0(sp)
 294:	0800                	add	s0,sp,16
  if (argc < 2) 
 296:	4705                	li	a4,1
 298:	02a75663          	bge	a4,a0,2c4 <main+0x36>
 29c:	87ae                	mv	a5,a1
  {
    find ("." , "");
    exit(0);
  }
  if (argc == 2)
 29e:	4709                	li	a4,2
 2a0:	04e50363          	beq	a0,a4,2e6 <main+0x58>
    find("." , argv[1]);
  else
    find(argv[1] , argv[2]);
 2a4:	698c                	ld	a1,16(a1)
 2a6:	6788                	ld	a0,8(a5)
 2a8:	00000097          	auipc	ra,0x0
 2ac:	dde080e7          	jalr	-546(ra) # 86 <find>
  if (!__FOUND_)
 2b0:	00001797          	auipc	a5,0x1
 2b4:	d507a783          	lw	a5,-688(a5) # 1000 <__FOUND_>
 2b8:	c3a9                	beqz	a5,2fa <main+0x6c>
    printf("find: No such file or directionary\n");
  exit(0);
 2ba:	4501                	li	a0,0
 2bc:	00000097          	auipc	ra,0x0
 2c0:	2d6080e7          	jalr	726(ra) # 592 <exit>
    find ("." , "");
 2c4:	00001597          	auipc	a1,0x1
 2c8:	82458593          	add	a1,a1,-2012 # ae8 <malloc+0x136>
 2cc:	00001517          	auipc	a0,0x1
 2d0:	82c50513          	add	a0,a0,-2004 # af8 <malloc+0x146>
 2d4:	00000097          	auipc	ra,0x0
 2d8:	db2080e7          	jalr	-590(ra) # 86 <find>
    exit(0);
 2dc:	4501                	li	a0,0
 2de:	00000097          	auipc	ra,0x0
 2e2:	2b4080e7          	jalr	692(ra) # 592 <exit>
    find("." , argv[1]);
 2e6:	658c                	ld	a1,8(a1)
 2e8:	00001517          	auipc	a0,0x1
 2ec:	81050513          	add	a0,a0,-2032 # af8 <malloc+0x146>
 2f0:	00000097          	auipc	ra,0x0
 2f4:	d96080e7          	jalr	-618(ra) # 86 <find>
 2f8:	bf65                	j	2b0 <main+0x22>
    printf("find: No such file or directionary\n");
 2fa:	00001517          	auipc	a0,0x1
 2fe:	80e50513          	add	a0,a0,-2034 # b08 <malloc+0x156>
 302:	00000097          	auipc	ra,0x0
 306:	5f8080e7          	jalr	1528(ra) # 8fa <printf>
 30a:	bf45                	j	2ba <main+0x2c>

000000000000030c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 30c:	1141                	add	sp,sp,-16
 30e:	e406                	sd	ra,8(sp)
 310:	e022                	sd	s0,0(sp)
 312:	0800                	add	s0,sp,16
  extern int main();
  main();
 314:	00000097          	auipc	ra,0x0
 318:	f7a080e7          	jalr	-134(ra) # 28e <main>
  exit(0);
 31c:	4501                	li	a0,0
 31e:	00000097          	auipc	ra,0x0
 322:	274080e7          	jalr	628(ra) # 592 <exit>

0000000000000326 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 326:	1141                	add	sp,sp,-16
 328:	e422                	sd	s0,8(sp)
 32a:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 32c:	87aa                	mv	a5,a0
 32e:	0585                	add	a1,a1,1
 330:	0785                	add	a5,a5,1
 332:	fff5c703          	lbu	a4,-1(a1)
 336:	fee78fa3          	sb	a4,-1(a5)
 33a:	fb75                	bnez	a4,32e <strcpy+0x8>
    ;
  return os;
}
 33c:	6422                	ld	s0,8(sp)
 33e:	0141                	add	sp,sp,16
 340:	8082                	ret

0000000000000342 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 342:	1141                	add	sp,sp,-16
 344:	e422                	sd	s0,8(sp)
 346:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 348:	00054783          	lbu	a5,0(a0)
 34c:	cb91                	beqz	a5,360 <strcmp+0x1e>
 34e:	0005c703          	lbu	a4,0(a1)
 352:	00f71763          	bne	a4,a5,360 <strcmp+0x1e>
    p++, q++;
 356:	0505                	add	a0,a0,1
 358:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 35a:	00054783          	lbu	a5,0(a0)
 35e:	fbe5                	bnez	a5,34e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 360:	0005c503          	lbu	a0,0(a1)
}
 364:	40a7853b          	subw	a0,a5,a0
 368:	6422                	ld	s0,8(sp)
 36a:	0141                	add	sp,sp,16
 36c:	8082                	ret

000000000000036e <strlen>:

uint
strlen(const char *s)
{
 36e:	1141                	add	sp,sp,-16
 370:	e422                	sd	s0,8(sp)
 372:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 374:	00054783          	lbu	a5,0(a0)
 378:	cf91                	beqz	a5,394 <strlen+0x26>
 37a:	0505                	add	a0,a0,1
 37c:	87aa                	mv	a5,a0
 37e:	86be                	mv	a3,a5
 380:	0785                	add	a5,a5,1
 382:	fff7c703          	lbu	a4,-1(a5)
 386:	ff65                	bnez	a4,37e <strlen+0x10>
 388:	40a6853b          	subw	a0,a3,a0
 38c:	2505                	addw	a0,a0,1
    ;
  return n;
}
 38e:	6422                	ld	s0,8(sp)
 390:	0141                	add	sp,sp,16
 392:	8082                	ret
  for(n = 0; s[n]; n++)
 394:	4501                	li	a0,0
 396:	bfe5                	j	38e <strlen+0x20>

0000000000000398 <memset>:

void*
memset(void *dst, int c, uint n)
{
 398:	1141                	add	sp,sp,-16
 39a:	e422                	sd	s0,8(sp)
 39c:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 39e:	ca19                	beqz	a2,3b4 <memset+0x1c>
 3a0:	87aa                	mv	a5,a0
 3a2:	1602                	sll	a2,a2,0x20
 3a4:	9201                	srl	a2,a2,0x20
 3a6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3aa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3ae:	0785                	add	a5,a5,1
 3b0:	fee79de3          	bne	a5,a4,3aa <memset+0x12>
  }
  return dst;
}
 3b4:	6422                	ld	s0,8(sp)
 3b6:	0141                	add	sp,sp,16
 3b8:	8082                	ret

00000000000003ba <strchr>:

char*
strchr(const char *s, char c)
{
 3ba:	1141                	add	sp,sp,-16
 3bc:	e422                	sd	s0,8(sp)
 3be:	0800                	add	s0,sp,16
  for(; *s; s++)
 3c0:	00054783          	lbu	a5,0(a0)
 3c4:	cb99                	beqz	a5,3da <strchr+0x20>
    if(*s == c)
 3c6:	00f58763          	beq	a1,a5,3d4 <strchr+0x1a>
  for(; *s; s++)
 3ca:	0505                	add	a0,a0,1
 3cc:	00054783          	lbu	a5,0(a0)
 3d0:	fbfd                	bnez	a5,3c6 <strchr+0xc>
      return (char*)s;
  return 0;
 3d2:	4501                	li	a0,0
}
 3d4:	6422                	ld	s0,8(sp)
 3d6:	0141                	add	sp,sp,16
 3d8:	8082                	ret
  return 0;
 3da:	4501                	li	a0,0
 3dc:	bfe5                	j	3d4 <strchr+0x1a>

00000000000003de <gets>:

char*
gets(char *buf, int max)
{
 3de:	711d                	add	sp,sp,-96
 3e0:	ec86                	sd	ra,88(sp)
 3e2:	e8a2                	sd	s0,80(sp)
 3e4:	e4a6                	sd	s1,72(sp)
 3e6:	e0ca                	sd	s2,64(sp)
 3e8:	fc4e                	sd	s3,56(sp)
 3ea:	f852                	sd	s4,48(sp)
 3ec:	f456                	sd	s5,40(sp)
 3ee:	f05a                	sd	s6,32(sp)
 3f0:	ec5e                	sd	s7,24(sp)
 3f2:	1080                	add	s0,sp,96
 3f4:	8baa                	mv	s7,a0
 3f6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3f8:	892a                	mv	s2,a0
 3fa:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3fc:	4aa9                	li	s5,10
 3fe:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 400:	89a6                	mv	s3,s1
 402:	2485                	addw	s1,s1,1
 404:	0344d863          	bge	s1,s4,434 <gets+0x56>
    cc = read(0, &c, 1);
 408:	4605                	li	a2,1
 40a:	faf40593          	add	a1,s0,-81
 40e:	4501                	li	a0,0
 410:	00000097          	auipc	ra,0x0
 414:	19a080e7          	jalr	410(ra) # 5aa <read>
    if(cc < 1)
 418:	00a05e63          	blez	a0,434 <gets+0x56>
    buf[i++] = c;
 41c:	faf44783          	lbu	a5,-81(s0)
 420:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 424:	01578763          	beq	a5,s5,432 <gets+0x54>
 428:	0905                	add	s2,s2,1
 42a:	fd679be3          	bne	a5,s6,400 <gets+0x22>
  for(i=0; i+1 < max; ){
 42e:	89a6                	mv	s3,s1
 430:	a011                	j	434 <gets+0x56>
 432:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 434:	99de                	add	s3,s3,s7
 436:	00098023          	sb	zero,0(s3)
  return buf;
}
 43a:	855e                	mv	a0,s7
 43c:	60e6                	ld	ra,88(sp)
 43e:	6446                	ld	s0,80(sp)
 440:	64a6                	ld	s1,72(sp)
 442:	6906                	ld	s2,64(sp)
 444:	79e2                	ld	s3,56(sp)
 446:	7a42                	ld	s4,48(sp)
 448:	7aa2                	ld	s5,40(sp)
 44a:	7b02                	ld	s6,32(sp)
 44c:	6be2                	ld	s7,24(sp)
 44e:	6125                	add	sp,sp,96
 450:	8082                	ret

0000000000000452 <stat>:

int
stat(const char *n, struct stat *st)
{
 452:	1101                	add	sp,sp,-32
 454:	ec06                	sd	ra,24(sp)
 456:	e822                	sd	s0,16(sp)
 458:	e426                	sd	s1,8(sp)
 45a:	e04a                	sd	s2,0(sp)
 45c:	1000                	add	s0,sp,32
 45e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 460:	4581                	li	a1,0
 462:	00000097          	auipc	ra,0x0
 466:	170080e7          	jalr	368(ra) # 5d2 <open>
  if(fd < 0)
 46a:	02054563          	bltz	a0,494 <stat+0x42>
 46e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 470:	85ca                	mv	a1,s2
 472:	00000097          	auipc	ra,0x0
 476:	178080e7          	jalr	376(ra) # 5ea <fstat>
 47a:	892a                	mv	s2,a0
  close(fd);
 47c:	8526                	mv	a0,s1
 47e:	00000097          	auipc	ra,0x0
 482:	13c080e7          	jalr	316(ra) # 5ba <close>
  return r;
}
 486:	854a                	mv	a0,s2
 488:	60e2                	ld	ra,24(sp)
 48a:	6442                	ld	s0,16(sp)
 48c:	64a2                	ld	s1,8(sp)
 48e:	6902                	ld	s2,0(sp)
 490:	6105                	add	sp,sp,32
 492:	8082                	ret
    return -1;
 494:	597d                	li	s2,-1
 496:	bfc5                	j	486 <stat+0x34>

0000000000000498 <atoi>:

int
atoi(const char *s)
{
 498:	1141                	add	sp,sp,-16
 49a:	e422                	sd	s0,8(sp)
 49c:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 49e:	00054683          	lbu	a3,0(a0)
 4a2:	fd06879b          	addw	a5,a3,-48
 4a6:	0ff7f793          	zext.b	a5,a5
 4aa:	4625                	li	a2,9
 4ac:	02f66863          	bltu	a2,a5,4dc <atoi+0x44>
 4b0:	872a                	mv	a4,a0
  n = 0;
 4b2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 4b4:	0705                	add	a4,a4,1
 4b6:	0025179b          	sllw	a5,a0,0x2
 4ba:	9fa9                	addw	a5,a5,a0
 4bc:	0017979b          	sllw	a5,a5,0x1
 4c0:	9fb5                	addw	a5,a5,a3
 4c2:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4c6:	00074683          	lbu	a3,0(a4)
 4ca:	fd06879b          	addw	a5,a3,-48
 4ce:	0ff7f793          	zext.b	a5,a5
 4d2:	fef671e3          	bgeu	a2,a5,4b4 <atoi+0x1c>
  return n;
}
 4d6:	6422                	ld	s0,8(sp)
 4d8:	0141                	add	sp,sp,16
 4da:	8082                	ret
  n = 0;
 4dc:	4501                	li	a0,0
 4de:	bfe5                	j	4d6 <atoi+0x3e>

00000000000004e0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4e0:	1141                	add	sp,sp,-16
 4e2:	e422                	sd	s0,8(sp)
 4e4:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4e6:	02b57463          	bgeu	a0,a1,50e <memmove+0x2e>
    while(n-- > 0)
 4ea:	00c05f63          	blez	a2,508 <memmove+0x28>
 4ee:	1602                	sll	a2,a2,0x20
 4f0:	9201                	srl	a2,a2,0x20
 4f2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4f6:	872a                	mv	a4,a0
      *dst++ = *src++;
 4f8:	0585                	add	a1,a1,1
 4fa:	0705                	add	a4,a4,1
 4fc:	fff5c683          	lbu	a3,-1(a1)
 500:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 504:	fee79ae3          	bne	a5,a4,4f8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 508:	6422                	ld	s0,8(sp)
 50a:	0141                	add	sp,sp,16
 50c:	8082                	ret
    dst += n;
 50e:	00c50733          	add	a4,a0,a2
    src += n;
 512:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 514:	fec05ae3          	blez	a2,508 <memmove+0x28>
 518:	fff6079b          	addw	a5,a2,-1
 51c:	1782                	sll	a5,a5,0x20
 51e:	9381                	srl	a5,a5,0x20
 520:	fff7c793          	not	a5,a5
 524:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 526:	15fd                	add	a1,a1,-1
 528:	177d                	add	a4,a4,-1
 52a:	0005c683          	lbu	a3,0(a1)
 52e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 532:	fee79ae3          	bne	a5,a4,526 <memmove+0x46>
 536:	bfc9                	j	508 <memmove+0x28>

0000000000000538 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 538:	1141                	add	sp,sp,-16
 53a:	e422                	sd	s0,8(sp)
 53c:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 53e:	ca05                	beqz	a2,56e <memcmp+0x36>
 540:	fff6069b          	addw	a3,a2,-1
 544:	1682                	sll	a3,a3,0x20
 546:	9281                	srl	a3,a3,0x20
 548:	0685                	add	a3,a3,1
 54a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 54c:	00054783          	lbu	a5,0(a0)
 550:	0005c703          	lbu	a4,0(a1)
 554:	00e79863          	bne	a5,a4,564 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 558:	0505                	add	a0,a0,1
    p2++;
 55a:	0585                	add	a1,a1,1
  while (n-- > 0) {
 55c:	fed518e3          	bne	a0,a3,54c <memcmp+0x14>
  }
  return 0;
 560:	4501                	li	a0,0
 562:	a019                	j	568 <memcmp+0x30>
      return *p1 - *p2;
 564:	40e7853b          	subw	a0,a5,a4
}
 568:	6422                	ld	s0,8(sp)
 56a:	0141                	add	sp,sp,16
 56c:	8082                	ret
  return 0;
 56e:	4501                	li	a0,0
 570:	bfe5                	j	568 <memcmp+0x30>

0000000000000572 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 572:	1141                	add	sp,sp,-16
 574:	e406                	sd	ra,8(sp)
 576:	e022                	sd	s0,0(sp)
 578:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 57a:	00000097          	auipc	ra,0x0
 57e:	f66080e7          	jalr	-154(ra) # 4e0 <memmove>
}
 582:	60a2                	ld	ra,8(sp)
 584:	6402                	ld	s0,0(sp)
 586:	0141                	add	sp,sp,16
 588:	8082                	ret

000000000000058a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 58a:	4885                	li	a7,1
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <exit>:
.global exit
exit:
 li a7, SYS_exit
 592:	4889                	li	a7,2
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <wait>:
.global wait
wait:
 li a7, SYS_wait
 59a:	488d                	li	a7,3
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5a2:	4891                	li	a7,4
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <read>:
.global read
read:
 li a7, SYS_read
 5aa:	4895                	li	a7,5
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <write>:
.global write
write:
 li a7, SYS_write
 5b2:	48c1                	li	a7,16
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <close>:
.global close
close:
 li a7, SYS_close
 5ba:	48d5                	li	a7,21
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5c2:	4899                	li	a7,6
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <exec>:
.global exec
exec:
 li a7, SYS_exec
 5ca:	489d                	li	a7,7
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <open>:
.global open
open:
 li a7, SYS_open
 5d2:	48bd                	li	a7,15
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5da:	48c5                	li	a7,17
 ecall
 5dc:	00000073          	ecall
 ret
 5e0:	8082                	ret

00000000000005e2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5e2:	48c9                	li	a7,18
 ecall
 5e4:	00000073          	ecall
 ret
 5e8:	8082                	ret

00000000000005ea <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5ea:	48a1                	li	a7,8
 ecall
 5ec:	00000073          	ecall
 ret
 5f0:	8082                	ret

00000000000005f2 <link>:
.global link
link:
 li a7, SYS_link
 5f2:	48cd                	li	a7,19
 ecall
 5f4:	00000073          	ecall
 ret
 5f8:	8082                	ret

00000000000005fa <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5fa:	48d1                	li	a7,20
 ecall
 5fc:	00000073          	ecall
 ret
 600:	8082                	ret

0000000000000602 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 602:	48a5                	li	a7,9
 ecall
 604:	00000073          	ecall
 ret
 608:	8082                	ret

000000000000060a <dup>:
.global dup
dup:
 li a7, SYS_dup
 60a:	48a9                	li	a7,10
 ecall
 60c:	00000073          	ecall
 ret
 610:	8082                	ret

0000000000000612 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 612:	48ad                	li	a7,11
 ecall
 614:	00000073          	ecall
 ret
 618:	8082                	ret

000000000000061a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 61a:	48b1                	li	a7,12
 ecall
 61c:	00000073          	ecall
 ret
 620:	8082                	ret

0000000000000622 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 622:	48b5                	li	a7,13
 ecall
 624:	00000073          	ecall
 ret
 628:	8082                	ret

000000000000062a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 62a:	48b9                	li	a7,14
 ecall
 62c:	00000073          	ecall
 ret
 630:	8082                	ret

0000000000000632 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 632:	1101                	add	sp,sp,-32
 634:	ec06                	sd	ra,24(sp)
 636:	e822                	sd	s0,16(sp)
 638:	1000                	add	s0,sp,32
 63a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 63e:	4605                	li	a2,1
 640:	fef40593          	add	a1,s0,-17
 644:	00000097          	auipc	ra,0x0
 648:	f6e080e7          	jalr	-146(ra) # 5b2 <write>
}
 64c:	60e2                	ld	ra,24(sp)
 64e:	6442                	ld	s0,16(sp)
 650:	6105                	add	sp,sp,32
 652:	8082                	ret

0000000000000654 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 654:	7139                	add	sp,sp,-64
 656:	fc06                	sd	ra,56(sp)
 658:	f822                	sd	s0,48(sp)
 65a:	f426                	sd	s1,40(sp)
 65c:	f04a                	sd	s2,32(sp)
 65e:	ec4e                	sd	s3,24(sp)
 660:	0080                	add	s0,sp,64
 662:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 664:	c299                	beqz	a3,66a <printint+0x16>
 666:	0805c963          	bltz	a1,6f8 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 66a:	2581                	sext.w	a1,a1
  neg = 0;
 66c:	4881                	li	a7,0
 66e:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 672:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 674:	2601                	sext.w	a2,a2
 676:	00000517          	auipc	a0,0x0
 67a:	51a50513          	add	a0,a0,1306 # b90 <digits>
 67e:	883a                	mv	a6,a4
 680:	2705                	addw	a4,a4,1
 682:	02c5f7bb          	remuw	a5,a1,a2
 686:	1782                	sll	a5,a5,0x20
 688:	9381                	srl	a5,a5,0x20
 68a:	97aa                	add	a5,a5,a0
 68c:	0007c783          	lbu	a5,0(a5)
 690:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 694:	0005879b          	sext.w	a5,a1
 698:	02c5d5bb          	divuw	a1,a1,a2
 69c:	0685                	add	a3,a3,1
 69e:	fec7f0e3          	bgeu	a5,a2,67e <printint+0x2a>
  if(neg)
 6a2:	00088c63          	beqz	a7,6ba <printint+0x66>
    buf[i++] = '-';
 6a6:	fd070793          	add	a5,a4,-48
 6aa:	00878733          	add	a4,a5,s0
 6ae:	02d00793          	li	a5,45
 6b2:	fef70823          	sb	a5,-16(a4)
 6b6:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 6ba:	02e05863          	blez	a4,6ea <printint+0x96>
 6be:	fc040793          	add	a5,s0,-64
 6c2:	00e78933          	add	s2,a5,a4
 6c6:	fff78993          	add	s3,a5,-1
 6ca:	99ba                	add	s3,s3,a4
 6cc:	377d                	addw	a4,a4,-1
 6ce:	1702                	sll	a4,a4,0x20
 6d0:	9301                	srl	a4,a4,0x20
 6d2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6d6:	fff94583          	lbu	a1,-1(s2)
 6da:	8526                	mv	a0,s1
 6dc:	00000097          	auipc	ra,0x0
 6e0:	f56080e7          	jalr	-170(ra) # 632 <putc>
  while(--i >= 0)
 6e4:	197d                	add	s2,s2,-1
 6e6:	ff3918e3          	bne	s2,s3,6d6 <printint+0x82>
}
 6ea:	70e2                	ld	ra,56(sp)
 6ec:	7442                	ld	s0,48(sp)
 6ee:	74a2                	ld	s1,40(sp)
 6f0:	7902                	ld	s2,32(sp)
 6f2:	69e2                	ld	s3,24(sp)
 6f4:	6121                	add	sp,sp,64
 6f6:	8082                	ret
    x = -xx;
 6f8:	40b005bb          	negw	a1,a1
    neg = 1;
 6fc:	4885                	li	a7,1
    x = -xx;
 6fe:	bf85                	j	66e <printint+0x1a>

0000000000000700 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 700:	715d                	add	sp,sp,-80
 702:	e486                	sd	ra,72(sp)
 704:	e0a2                	sd	s0,64(sp)
 706:	fc26                	sd	s1,56(sp)
 708:	f84a                	sd	s2,48(sp)
 70a:	f44e                	sd	s3,40(sp)
 70c:	f052                	sd	s4,32(sp)
 70e:	ec56                	sd	s5,24(sp)
 710:	e85a                	sd	s6,16(sp)
 712:	e45e                	sd	s7,8(sp)
 714:	e062                	sd	s8,0(sp)
 716:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 718:	0005c903          	lbu	s2,0(a1)
 71c:	18090c63          	beqz	s2,8b4 <vprintf+0x1b4>
 720:	8aaa                	mv	s5,a0
 722:	8bb2                	mv	s7,a2
 724:	00158493          	add	s1,a1,1
  state = 0;
 728:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 72a:	02500a13          	li	s4,37
 72e:	4b55                	li	s6,21
 730:	a839                	j	74e <vprintf+0x4e>
        putc(fd, c);
 732:	85ca                	mv	a1,s2
 734:	8556                	mv	a0,s5
 736:	00000097          	auipc	ra,0x0
 73a:	efc080e7          	jalr	-260(ra) # 632 <putc>
 73e:	a019                	j	744 <vprintf+0x44>
    } else if(state == '%'){
 740:	01498d63          	beq	s3,s4,75a <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 744:	0485                	add	s1,s1,1
 746:	fff4c903          	lbu	s2,-1(s1)
 74a:	16090563          	beqz	s2,8b4 <vprintf+0x1b4>
    if(state == 0){
 74e:	fe0999e3          	bnez	s3,740 <vprintf+0x40>
      if(c == '%'){
 752:	ff4910e3          	bne	s2,s4,732 <vprintf+0x32>
        state = '%';
 756:	89d2                	mv	s3,s4
 758:	b7f5                	j	744 <vprintf+0x44>
      if(c == 'd'){
 75a:	13490263          	beq	s2,s4,87e <vprintf+0x17e>
 75e:	f9d9079b          	addw	a5,s2,-99
 762:	0ff7f793          	zext.b	a5,a5
 766:	12fb6563          	bltu	s6,a5,890 <vprintf+0x190>
 76a:	f9d9079b          	addw	a5,s2,-99
 76e:	0ff7f713          	zext.b	a4,a5
 772:	10eb6f63          	bltu	s6,a4,890 <vprintf+0x190>
 776:	00271793          	sll	a5,a4,0x2
 77a:	00000717          	auipc	a4,0x0
 77e:	3be70713          	add	a4,a4,958 # b38 <malloc+0x186>
 782:	97ba                	add	a5,a5,a4
 784:	439c                	lw	a5,0(a5)
 786:	97ba                	add	a5,a5,a4
 788:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 78a:	008b8913          	add	s2,s7,8
 78e:	4685                	li	a3,1
 790:	4629                	li	a2,10
 792:	000ba583          	lw	a1,0(s7)
 796:	8556                	mv	a0,s5
 798:	00000097          	auipc	ra,0x0
 79c:	ebc080e7          	jalr	-324(ra) # 654 <printint>
 7a0:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7a2:	4981                	li	s3,0
 7a4:	b745                	j	744 <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7a6:	008b8913          	add	s2,s7,8
 7aa:	4681                	li	a3,0
 7ac:	4629                	li	a2,10
 7ae:	000ba583          	lw	a1,0(s7)
 7b2:	8556                	mv	a0,s5
 7b4:	00000097          	auipc	ra,0x0
 7b8:	ea0080e7          	jalr	-352(ra) # 654 <printint>
 7bc:	8bca                	mv	s7,s2
      state = 0;
 7be:	4981                	li	s3,0
 7c0:	b751                	j	744 <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 7c2:	008b8913          	add	s2,s7,8
 7c6:	4681                	li	a3,0
 7c8:	4641                	li	a2,16
 7ca:	000ba583          	lw	a1,0(s7)
 7ce:	8556                	mv	a0,s5
 7d0:	00000097          	auipc	ra,0x0
 7d4:	e84080e7          	jalr	-380(ra) # 654 <printint>
 7d8:	8bca                	mv	s7,s2
      state = 0;
 7da:	4981                	li	s3,0
 7dc:	b7a5                	j	744 <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 7de:	008b8c13          	add	s8,s7,8
 7e2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7e6:	03000593          	li	a1,48
 7ea:	8556                	mv	a0,s5
 7ec:	00000097          	auipc	ra,0x0
 7f0:	e46080e7          	jalr	-442(ra) # 632 <putc>
  putc(fd, 'x');
 7f4:	07800593          	li	a1,120
 7f8:	8556                	mv	a0,s5
 7fa:	00000097          	auipc	ra,0x0
 7fe:	e38080e7          	jalr	-456(ra) # 632 <putc>
 802:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 804:	00000b97          	auipc	s7,0x0
 808:	38cb8b93          	add	s7,s7,908 # b90 <digits>
 80c:	03c9d793          	srl	a5,s3,0x3c
 810:	97de                	add	a5,a5,s7
 812:	0007c583          	lbu	a1,0(a5)
 816:	8556                	mv	a0,s5
 818:	00000097          	auipc	ra,0x0
 81c:	e1a080e7          	jalr	-486(ra) # 632 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 820:	0992                	sll	s3,s3,0x4
 822:	397d                	addw	s2,s2,-1
 824:	fe0914e3          	bnez	s2,80c <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 828:	8be2                	mv	s7,s8
      state = 0;
 82a:	4981                	li	s3,0
 82c:	bf21                	j	744 <vprintf+0x44>
        s = va_arg(ap, char*);
 82e:	008b8993          	add	s3,s7,8
 832:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 836:	02090163          	beqz	s2,858 <vprintf+0x158>
        while(*s != 0){
 83a:	00094583          	lbu	a1,0(s2)
 83e:	c9a5                	beqz	a1,8ae <vprintf+0x1ae>
          putc(fd, *s);
 840:	8556                	mv	a0,s5
 842:	00000097          	auipc	ra,0x0
 846:	df0080e7          	jalr	-528(ra) # 632 <putc>
          s++;
 84a:	0905                	add	s2,s2,1
        while(*s != 0){
 84c:	00094583          	lbu	a1,0(s2)
 850:	f9e5                	bnez	a1,840 <vprintf+0x140>
        s = va_arg(ap, char*);
 852:	8bce                	mv	s7,s3
      state = 0;
 854:	4981                	li	s3,0
 856:	b5fd                	j	744 <vprintf+0x44>
          s = "(null)";
 858:	00000917          	auipc	s2,0x0
 85c:	2d890913          	add	s2,s2,728 # b30 <malloc+0x17e>
        while(*s != 0){
 860:	02800593          	li	a1,40
 864:	bff1                	j	840 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 866:	008b8913          	add	s2,s7,8
 86a:	000bc583          	lbu	a1,0(s7)
 86e:	8556                	mv	a0,s5
 870:	00000097          	auipc	ra,0x0
 874:	dc2080e7          	jalr	-574(ra) # 632 <putc>
 878:	8bca                	mv	s7,s2
      state = 0;
 87a:	4981                	li	s3,0
 87c:	b5e1                	j	744 <vprintf+0x44>
        putc(fd, c);
 87e:	02500593          	li	a1,37
 882:	8556                	mv	a0,s5
 884:	00000097          	auipc	ra,0x0
 888:	dae080e7          	jalr	-594(ra) # 632 <putc>
      state = 0;
 88c:	4981                	li	s3,0
 88e:	bd5d                	j	744 <vprintf+0x44>
        putc(fd, '%');
 890:	02500593          	li	a1,37
 894:	8556                	mv	a0,s5
 896:	00000097          	auipc	ra,0x0
 89a:	d9c080e7          	jalr	-612(ra) # 632 <putc>
        putc(fd, c);
 89e:	85ca                	mv	a1,s2
 8a0:	8556                	mv	a0,s5
 8a2:	00000097          	auipc	ra,0x0
 8a6:	d90080e7          	jalr	-624(ra) # 632 <putc>
      state = 0;
 8aa:	4981                	li	s3,0
 8ac:	bd61                	j	744 <vprintf+0x44>
        s = va_arg(ap, char*);
 8ae:	8bce                	mv	s7,s3
      state = 0;
 8b0:	4981                	li	s3,0
 8b2:	bd49                	j	744 <vprintf+0x44>
    }
  }
}
 8b4:	60a6                	ld	ra,72(sp)
 8b6:	6406                	ld	s0,64(sp)
 8b8:	74e2                	ld	s1,56(sp)
 8ba:	7942                	ld	s2,48(sp)
 8bc:	79a2                	ld	s3,40(sp)
 8be:	7a02                	ld	s4,32(sp)
 8c0:	6ae2                	ld	s5,24(sp)
 8c2:	6b42                	ld	s6,16(sp)
 8c4:	6ba2                	ld	s7,8(sp)
 8c6:	6c02                	ld	s8,0(sp)
 8c8:	6161                	add	sp,sp,80
 8ca:	8082                	ret

00000000000008cc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8cc:	715d                	add	sp,sp,-80
 8ce:	ec06                	sd	ra,24(sp)
 8d0:	e822                	sd	s0,16(sp)
 8d2:	1000                	add	s0,sp,32
 8d4:	e010                	sd	a2,0(s0)
 8d6:	e414                	sd	a3,8(s0)
 8d8:	e818                	sd	a4,16(s0)
 8da:	ec1c                	sd	a5,24(s0)
 8dc:	03043023          	sd	a6,32(s0)
 8e0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8e4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8e8:	8622                	mv	a2,s0
 8ea:	00000097          	auipc	ra,0x0
 8ee:	e16080e7          	jalr	-490(ra) # 700 <vprintf>
}
 8f2:	60e2                	ld	ra,24(sp)
 8f4:	6442                	ld	s0,16(sp)
 8f6:	6161                	add	sp,sp,80
 8f8:	8082                	ret

00000000000008fa <printf>:

void
printf(const char *fmt, ...)
{
 8fa:	711d                	add	sp,sp,-96
 8fc:	ec06                	sd	ra,24(sp)
 8fe:	e822                	sd	s0,16(sp)
 900:	1000                	add	s0,sp,32
 902:	e40c                	sd	a1,8(s0)
 904:	e810                	sd	a2,16(s0)
 906:	ec14                	sd	a3,24(s0)
 908:	f018                	sd	a4,32(s0)
 90a:	f41c                	sd	a5,40(s0)
 90c:	03043823          	sd	a6,48(s0)
 910:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 914:	00840613          	add	a2,s0,8
 918:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 91c:	85aa                	mv	a1,a0
 91e:	4505                	li	a0,1
 920:	00000097          	auipc	ra,0x0
 924:	de0080e7          	jalr	-544(ra) # 700 <vprintf>
}
 928:	60e2                	ld	ra,24(sp)
 92a:	6442                	ld	s0,16(sp)
 92c:	6125                	add	sp,sp,96
 92e:	8082                	ret

0000000000000930 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 930:	1141                	add	sp,sp,-16
 932:	e422                	sd	s0,8(sp)
 934:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 936:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 93a:	00000797          	auipc	a5,0x0
 93e:	6ce7b783          	ld	a5,1742(a5) # 1008 <freep>
 942:	a02d                	j	96c <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 944:	4618                	lw	a4,8(a2)
 946:	9f2d                	addw	a4,a4,a1
 948:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 94c:	6398                	ld	a4,0(a5)
 94e:	6310                	ld	a2,0(a4)
 950:	a83d                	j	98e <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 952:	ff852703          	lw	a4,-8(a0)
 956:	9f31                	addw	a4,a4,a2
 958:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 95a:	ff053683          	ld	a3,-16(a0)
 95e:	a091                	j	9a2 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 960:	6398                	ld	a4,0(a5)
 962:	00e7e463          	bltu	a5,a4,96a <free+0x3a>
 966:	00e6ea63          	bltu	a3,a4,97a <free+0x4a>
{
 96a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 96c:	fed7fae3          	bgeu	a5,a3,960 <free+0x30>
 970:	6398                	ld	a4,0(a5)
 972:	00e6e463          	bltu	a3,a4,97a <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 976:	fee7eae3          	bltu	a5,a4,96a <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 97a:	ff852583          	lw	a1,-8(a0)
 97e:	6390                	ld	a2,0(a5)
 980:	02059813          	sll	a6,a1,0x20
 984:	01c85713          	srl	a4,a6,0x1c
 988:	9736                	add	a4,a4,a3
 98a:	fae60de3          	beq	a2,a4,944 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 98e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 992:	4790                	lw	a2,8(a5)
 994:	02061593          	sll	a1,a2,0x20
 998:	01c5d713          	srl	a4,a1,0x1c
 99c:	973e                	add	a4,a4,a5
 99e:	fae68ae3          	beq	a3,a4,952 <free+0x22>
    p->s.ptr = bp->s.ptr;
 9a2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9a4:	00000717          	auipc	a4,0x0
 9a8:	66f73223          	sd	a5,1636(a4) # 1008 <freep>
}
 9ac:	6422                	ld	s0,8(sp)
 9ae:	0141                	add	sp,sp,16
 9b0:	8082                	ret

00000000000009b2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9b2:	7139                	add	sp,sp,-64
 9b4:	fc06                	sd	ra,56(sp)
 9b6:	f822                	sd	s0,48(sp)
 9b8:	f426                	sd	s1,40(sp)
 9ba:	f04a                	sd	s2,32(sp)
 9bc:	ec4e                	sd	s3,24(sp)
 9be:	e852                	sd	s4,16(sp)
 9c0:	e456                	sd	s5,8(sp)
 9c2:	e05a                	sd	s6,0(sp)
 9c4:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9c6:	02051493          	sll	s1,a0,0x20
 9ca:	9081                	srl	s1,s1,0x20
 9cc:	04bd                	add	s1,s1,15
 9ce:	8091                	srl	s1,s1,0x4
 9d0:	0014899b          	addw	s3,s1,1
 9d4:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 9d6:	00000517          	auipc	a0,0x0
 9da:	63253503          	ld	a0,1586(a0) # 1008 <freep>
 9de:	c515                	beqz	a0,a0a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9e2:	4798                	lw	a4,8(a5)
 9e4:	02977f63          	bgeu	a4,s1,a22 <malloc+0x70>
  if(nu < 4096)
 9e8:	8a4e                	mv	s4,s3
 9ea:	0009871b          	sext.w	a4,s3
 9ee:	6685                	lui	a3,0x1
 9f0:	00d77363          	bgeu	a4,a3,9f6 <malloc+0x44>
 9f4:	6a05                	lui	s4,0x1
 9f6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9fa:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9fe:	00000917          	auipc	s2,0x0
 a02:	60a90913          	add	s2,s2,1546 # 1008 <freep>
  if(p == (char*)-1)
 a06:	5afd                	li	s5,-1
 a08:	a895                	j	a7c <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 a0a:	00000797          	auipc	a5,0x0
 a0e:	60678793          	add	a5,a5,1542 # 1010 <base>
 a12:	00000717          	auipc	a4,0x0
 a16:	5ef73b23          	sd	a5,1526(a4) # 1008 <freep>
 a1a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a1c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a20:	b7e1                	j	9e8 <malloc+0x36>
      if(p->s.size == nunits)
 a22:	02e48c63          	beq	s1,a4,a5a <malloc+0xa8>
        p->s.size -= nunits;
 a26:	4137073b          	subw	a4,a4,s3
 a2a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a2c:	02071693          	sll	a3,a4,0x20
 a30:	01c6d713          	srl	a4,a3,0x1c
 a34:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a36:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a3a:	00000717          	auipc	a4,0x0
 a3e:	5ca73723          	sd	a0,1486(a4) # 1008 <freep>
      return (void*)(p + 1);
 a42:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a46:	70e2                	ld	ra,56(sp)
 a48:	7442                	ld	s0,48(sp)
 a4a:	74a2                	ld	s1,40(sp)
 a4c:	7902                	ld	s2,32(sp)
 a4e:	69e2                	ld	s3,24(sp)
 a50:	6a42                	ld	s4,16(sp)
 a52:	6aa2                	ld	s5,8(sp)
 a54:	6b02                	ld	s6,0(sp)
 a56:	6121                	add	sp,sp,64
 a58:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a5a:	6398                	ld	a4,0(a5)
 a5c:	e118                	sd	a4,0(a0)
 a5e:	bff1                	j	a3a <malloc+0x88>
  hp->s.size = nu;
 a60:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a64:	0541                	add	a0,a0,16
 a66:	00000097          	auipc	ra,0x0
 a6a:	eca080e7          	jalr	-310(ra) # 930 <free>
  return freep;
 a6e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a72:	d971                	beqz	a0,a46 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a74:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a76:	4798                	lw	a4,8(a5)
 a78:	fa9775e3          	bgeu	a4,s1,a22 <malloc+0x70>
    if(p == freep)
 a7c:	00093703          	ld	a4,0(s2)
 a80:	853e                	mv	a0,a5
 a82:	fef719e3          	bne	a4,a5,a74 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 a86:	8552                	mv	a0,s4
 a88:	00000097          	auipc	ra,0x0
 a8c:	b92080e7          	jalr	-1134(ra) # 61a <sbrk>
  if(p == (char*)-1)
 a90:	fd5518e3          	bne	a0,s5,a60 <malloc+0xae>
        return 0;
 a94:	4501                	li	a0,0
 a96:	bf45                	j	a46 <malloc+0x94>
