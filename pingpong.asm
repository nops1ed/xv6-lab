
user/_pingpong：     文件格式 elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

//remain old C style

int
main (int argc , char *argv[])
{
   0:	7179                	add	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	add	s0,sp,48
	if (argc != 1)
   e:	4785                	li	a5,1
  10:	00f50f63          	beq	a0,a5,2e <main+0x2e>
	{
		printf("Too Much arguments\n");
  14:	00001517          	auipc	a0,0x1
  18:	8fc50513          	add	a0,a0,-1796 # 910 <malloc+0xe6>
  1c:	00000097          	auipc	ra,0x0
  20:	756080e7          	jalr	1878(ra) # 772 <printf>
		exit(1);
  24:	4505                	li	a0,1
  26:	00000097          	auipc	ra,0x0
  2a:	3e4080e7          	jalr	996(ra) # 40a <exit>
	}
//Here we allocate arrays to hold pipe fd
	//pipe from parent to child
  int *p1 = (int *)malloc(sizeof(int) * 2);
  2e:	4521                	li	a0,8
  30:	00000097          	auipc	ra,0x0
  34:	7fa080e7          	jalr	2042(ra) # 82a <malloc>
  38:	84aa                	mv	s1,a0
  pipe(p1);
  3a:	00000097          	auipc	ra,0x0
  3e:	3e0080e7          	jalr	992(ra) # 41a <pipe>
	//pipe from child to parent
  int *p2 = (int *)malloc(sizeof(int) * 2);
  42:	4521                	li	a0,8
  44:	00000097          	auipc	ra,0x0
  48:	7e6080e7          	jalr	2022(ra) # 82a <malloc>
  4c:	892a                	mv	s2,a0
	pipe(p2);
  4e:	00000097          	auipc	ra,0x0
  52:	3cc080e7          	jalr	972(ra) # 41a <pipe>
	if (fork() == 0)
  56:	00000097          	auipc	ra,0x0
  5a:	3ac080e7          	jalr	940(ra) # 402 <fork>
  5e:	e951                	bnez	a0,f2 <main+0xf2>
	{
    close(p1[0]);
  60:	4088                	lw	a0,0(s1)
  62:	00000097          	auipc	ra,0x0
  66:	3d0080e7          	jalr	976(ra) # 432 <close>
    close(p2[1]);
  6a:	00492503          	lw	a0,4(s2)
  6e:	00000097          	auipc	ra,0x0
  72:	3c4080e7          	jalr	964(ra) # 432 <close>
    char *buf = (char *)malloc(sizeof(char) * 32);
  76:	02000513          	li	a0,32
  7a:	00000097          	auipc	ra,0x0
  7e:	7b0080e7          	jalr	1968(ra) # 82a <malloc>
  82:	89aa                	mv	s3,a0
    *buf = '\0';
  84:	00050023          	sb	zero,0(a0)
		//parent should bind its output stream to  pipe_1
		read (p2[0] , buf , 5);
  88:	4615                	li	a2,5
  8a:	85aa                	mv	a1,a0
  8c:	00092503          	lw	a0,0(s2)
  90:	00000097          	auipc	ra,0x0
  94:	392080e7          	jalr	914(ra) # 422 <read>
    close(p2[0]);
  98:	00092503          	lw	a0,0(s2)
  9c:	00000097          	auipc	ra,0x0
  a0:	396080e7          	jalr	918(ra) # 432 <close>
		printf ("%d: received %s\n" , getpid() , buf);
  a4:	00000097          	auipc	ra,0x0
  a8:	3e6080e7          	jalr	998(ra) # 48a <getpid>
  ac:	85aa                	mv	a1,a0
  ae:	864e                	mv	a2,s3
  b0:	00001517          	auipc	a0,0x1
  b4:	87850513          	add	a0,a0,-1928 # 928 <malloc+0xfe>
  b8:	00000097          	auipc	ra,0x0
  bc:	6ba080e7          	jalr	1722(ra) # 772 <printf>
		write (p1[1] , "pong", 5);
  c0:	4615                	li	a2,5
  c2:	00001597          	auipc	a1,0x1
  c6:	87e58593          	add	a1,a1,-1922 # 940 <malloc+0x116>
  ca:	40c8                	lw	a0,4(s1)
  cc:	00000097          	auipc	ra,0x0
  d0:	35e080e7          	jalr	862(ra) # 42a <write>
    close(p1[1]);
  d4:	40c8                	lw	a0,4(s1)
  d6:	00000097          	auipc	ra,0x0
  da:	35c080e7          	jalr	860(ra) # 432 <close>
    free(buf);
  de:	854e                	mv	a0,s3
  e0:	00000097          	auipc	ra,0x0
  e4:	6c8080e7          	jalr	1736(ra) # 7a8 <free>
		exit(0);
  e8:	4501                	li	a0,0
  ea:	00000097          	auipc	ra,0x0
  ee:	320080e7          	jalr	800(ra) # 40a <exit>
	}
	else {
    close(p1[1]);
  f2:	40c8                	lw	a0,4(s1)
  f4:	00000097          	auipc	ra,0x0
  f8:	33e080e7          	jalr	830(ra) # 432 <close>
    close(p2[0]);
  fc:	00092503          	lw	a0,0(s2)
 100:	00000097          	auipc	ra,0x0
 104:	332080e7          	jalr	818(ra) # 432 <close>
    char *buf = (char *)malloc(sizeof(char) * 32);
 108:	02000513          	li	a0,32
 10c:	00000097          	auipc	ra,0x0
 110:	71e080e7          	jalr	1822(ra) # 82a <malloc>
 114:	89aa                	mv	s3,a0
    *buf = '\0';
 116:	00050023          	sb	zero,0(a0)
		write (p2[1] , "ping", 5);
 11a:	4615                	li	a2,5
 11c:	00001597          	auipc	a1,0x1
 120:	82c58593          	add	a1,a1,-2004 # 948 <malloc+0x11e>
 124:	00492503          	lw	a0,4(s2)
 128:	00000097          	auipc	ra,0x0
 12c:	302080e7          	jalr	770(ra) # 42a <write>
    close(p2[1]);
 130:	00492503          	lw	a0,4(s2)
 134:	00000097          	auipc	ra,0x0
 138:	2fe080e7          	jalr	766(ra) # 432 <close>
		read(p1[0], buf , 5);
 13c:	4615                	li	a2,5
 13e:	85ce                	mv	a1,s3
 140:	4088                	lw	a0,0(s1)
 142:	00000097          	auipc	ra,0x0
 146:	2e0080e7          	jalr	736(ra) # 422 <read>
    close(p1[0]);
 14a:	4088                	lw	a0,0(s1)
 14c:	00000097          	auipc	ra,0x0
 150:	2e6080e7          	jalr	742(ra) # 432 <close>
		printf ("%d: recevied %s\n" , getpid() , buf);
 154:	00000097          	auipc	ra,0x0
 158:	336080e7          	jalr	822(ra) # 48a <getpid>
 15c:	85aa                	mv	a1,a0
 15e:	864e                	mv	a2,s3
 160:	00000517          	auipc	a0,0x0
 164:	7f050513          	add	a0,a0,2032 # 950 <malloc+0x126>
 168:	00000097          	auipc	ra,0x0
 16c:	60a080e7          	jalr	1546(ra) # 772 <printf>
    free(buf);
 170:	854e                	mv	a0,s3
 172:	00000097          	auipc	ra,0x0
 176:	636080e7          	jalr	1590(ra) # 7a8 <free>
    exit(0);
 17a:	4501                	li	a0,0
 17c:	00000097          	auipc	ra,0x0
 180:	28e080e7          	jalr	654(ra) # 40a <exit>

0000000000000184 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 184:	1141                	add	sp,sp,-16
 186:	e406                	sd	ra,8(sp)
 188:	e022                	sd	s0,0(sp)
 18a:	0800                	add	s0,sp,16
  extern int main();
  main();
 18c:	00000097          	auipc	ra,0x0
 190:	e74080e7          	jalr	-396(ra) # 0 <main>
  exit(0);
 194:	4501                	li	a0,0
 196:	00000097          	auipc	ra,0x0
 19a:	274080e7          	jalr	628(ra) # 40a <exit>

000000000000019e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 19e:	1141                	add	sp,sp,-16
 1a0:	e422                	sd	s0,8(sp)
 1a2:	0800                	add	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1a4:	87aa                	mv	a5,a0
 1a6:	0585                	add	a1,a1,1
 1a8:	0785                	add	a5,a5,1
 1aa:	fff5c703          	lbu	a4,-1(a1)
 1ae:	fee78fa3          	sb	a4,-1(a5)
 1b2:	fb75                	bnez	a4,1a6 <strcpy+0x8>
    ;
  return os;
}
 1b4:	6422                	ld	s0,8(sp)
 1b6:	0141                	add	sp,sp,16
 1b8:	8082                	ret

00000000000001ba <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1ba:	1141                	add	sp,sp,-16
 1bc:	e422                	sd	s0,8(sp)
 1be:	0800                	add	s0,sp,16
  while(*p && *p == *q)
 1c0:	00054783          	lbu	a5,0(a0)
 1c4:	cb91                	beqz	a5,1d8 <strcmp+0x1e>
 1c6:	0005c703          	lbu	a4,0(a1)
 1ca:	00f71763          	bne	a4,a5,1d8 <strcmp+0x1e>
    p++, q++;
 1ce:	0505                	add	a0,a0,1
 1d0:	0585                	add	a1,a1,1
  while(*p && *p == *q)
 1d2:	00054783          	lbu	a5,0(a0)
 1d6:	fbe5                	bnez	a5,1c6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1d8:	0005c503          	lbu	a0,0(a1)
}
 1dc:	40a7853b          	subw	a0,a5,a0
 1e0:	6422                	ld	s0,8(sp)
 1e2:	0141                	add	sp,sp,16
 1e4:	8082                	ret

00000000000001e6 <strlen>:

uint
strlen(const char *s)
{
 1e6:	1141                	add	sp,sp,-16
 1e8:	e422                	sd	s0,8(sp)
 1ea:	0800                	add	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1ec:	00054783          	lbu	a5,0(a0)
 1f0:	cf91                	beqz	a5,20c <strlen+0x26>
 1f2:	0505                	add	a0,a0,1
 1f4:	87aa                	mv	a5,a0
 1f6:	86be                	mv	a3,a5
 1f8:	0785                	add	a5,a5,1
 1fa:	fff7c703          	lbu	a4,-1(a5)
 1fe:	ff65                	bnez	a4,1f6 <strlen+0x10>
 200:	40a6853b          	subw	a0,a3,a0
 204:	2505                	addw	a0,a0,1
    ;
  return n;
}
 206:	6422                	ld	s0,8(sp)
 208:	0141                	add	sp,sp,16
 20a:	8082                	ret
  for(n = 0; s[n]; n++)
 20c:	4501                	li	a0,0
 20e:	bfe5                	j	206 <strlen+0x20>

0000000000000210 <memset>:

void*
memset(void *dst, int c, uint n)
{
 210:	1141                	add	sp,sp,-16
 212:	e422                	sd	s0,8(sp)
 214:	0800                	add	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 216:	ca19                	beqz	a2,22c <memset+0x1c>
 218:	87aa                	mv	a5,a0
 21a:	1602                	sll	a2,a2,0x20
 21c:	9201                	srl	a2,a2,0x20
 21e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 222:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 226:	0785                	add	a5,a5,1
 228:	fee79de3          	bne	a5,a4,222 <memset+0x12>
  }
  return dst;
}
 22c:	6422                	ld	s0,8(sp)
 22e:	0141                	add	sp,sp,16
 230:	8082                	ret

0000000000000232 <strchr>:

char*
strchr(const char *s, char c)
{
 232:	1141                	add	sp,sp,-16
 234:	e422                	sd	s0,8(sp)
 236:	0800                	add	s0,sp,16
  for(; *s; s++)
 238:	00054783          	lbu	a5,0(a0)
 23c:	cb99                	beqz	a5,252 <strchr+0x20>
    if(*s == c)
 23e:	00f58763          	beq	a1,a5,24c <strchr+0x1a>
  for(; *s; s++)
 242:	0505                	add	a0,a0,1
 244:	00054783          	lbu	a5,0(a0)
 248:	fbfd                	bnez	a5,23e <strchr+0xc>
      return (char*)s;
  return 0;
 24a:	4501                	li	a0,0
}
 24c:	6422                	ld	s0,8(sp)
 24e:	0141                	add	sp,sp,16
 250:	8082                	ret
  return 0;
 252:	4501                	li	a0,0
 254:	bfe5                	j	24c <strchr+0x1a>

0000000000000256 <gets>:

char*
gets(char *buf, int max)
{
 256:	711d                	add	sp,sp,-96
 258:	ec86                	sd	ra,88(sp)
 25a:	e8a2                	sd	s0,80(sp)
 25c:	e4a6                	sd	s1,72(sp)
 25e:	e0ca                	sd	s2,64(sp)
 260:	fc4e                	sd	s3,56(sp)
 262:	f852                	sd	s4,48(sp)
 264:	f456                	sd	s5,40(sp)
 266:	f05a                	sd	s6,32(sp)
 268:	ec5e                	sd	s7,24(sp)
 26a:	1080                	add	s0,sp,96
 26c:	8baa                	mv	s7,a0
 26e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 270:	892a                	mv	s2,a0
 272:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 274:	4aa9                	li	s5,10
 276:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 278:	89a6                	mv	s3,s1
 27a:	2485                	addw	s1,s1,1
 27c:	0344d863          	bge	s1,s4,2ac <gets+0x56>
    cc = read(0, &c, 1);
 280:	4605                	li	a2,1
 282:	faf40593          	add	a1,s0,-81
 286:	4501                	li	a0,0
 288:	00000097          	auipc	ra,0x0
 28c:	19a080e7          	jalr	410(ra) # 422 <read>
    if(cc < 1)
 290:	00a05e63          	blez	a0,2ac <gets+0x56>
    buf[i++] = c;
 294:	faf44783          	lbu	a5,-81(s0)
 298:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 29c:	01578763          	beq	a5,s5,2aa <gets+0x54>
 2a0:	0905                	add	s2,s2,1
 2a2:	fd679be3          	bne	a5,s6,278 <gets+0x22>
  for(i=0; i+1 < max; ){
 2a6:	89a6                	mv	s3,s1
 2a8:	a011                	j	2ac <gets+0x56>
 2aa:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2ac:	99de                	add	s3,s3,s7
 2ae:	00098023          	sb	zero,0(s3)
  return buf;
}
 2b2:	855e                	mv	a0,s7
 2b4:	60e6                	ld	ra,88(sp)
 2b6:	6446                	ld	s0,80(sp)
 2b8:	64a6                	ld	s1,72(sp)
 2ba:	6906                	ld	s2,64(sp)
 2bc:	79e2                	ld	s3,56(sp)
 2be:	7a42                	ld	s4,48(sp)
 2c0:	7aa2                	ld	s5,40(sp)
 2c2:	7b02                	ld	s6,32(sp)
 2c4:	6be2                	ld	s7,24(sp)
 2c6:	6125                	add	sp,sp,96
 2c8:	8082                	ret

00000000000002ca <stat>:

int
stat(const char *n, struct stat *st)
{
 2ca:	1101                	add	sp,sp,-32
 2cc:	ec06                	sd	ra,24(sp)
 2ce:	e822                	sd	s0,16(sp)
 2d0:	e426                	sd	s1,8(sp)
 2d2:	e04a                	sd	s2,0(sp)
 2d4:	1000                	add	s0,sp,32
 2d6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d8:	4581                	li	a1,0
 2da:	00000097          	auipc	ra,0x0
 2de:	170080e7          	jalr	368(ra) # 44a <open>
  if(fd < 0)
 2e2:	02054563          	bltz	a0,30c <stat+0x42>
 2e6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2e8:	85ca                	mv	a1,s2
 2ea:	00000097          	auipc	ra,0x0
 2ee:	178080e7          	jalr	376(ra) # 462 <fstat>
 2f2:	892a                	mv	s2,a0
  close(fd);
 2f4:	8526                	mv	a0,s1
 2f6:	00000097          	auipc	ra,0x0
 2fa:	13c080e7          	jalr	316(ra) # 432 <close>
  return r;
}
 2fe:	854a                	mv	a0,s2
 300:	60e2                	ld	ra,24(sp)
 302:	6442                	ld	s0,16(sp)
 304:	64a2                	ld	s1,8(sp)
 306:	6902                	ld	s2,0(sp)
 308:	6105                	add	sp,sp,32
 30a:	8082                	ret
    return -1;
 30c:	597d                	li	s2,-1
 30e:	bfc5                	j	2fe <stat+0x34>

0000000000000310 <atoi>:

int
atoi(const char *s)
{
 310:	1141                	add	sp,sp,-16
 312:	e422                	sd	s0,8(sp)
 314:	0800                	add	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 316:	00054683          	lbu	a3,0(a0)
 31a:	fd06879b          	addw	a5,a3,-48
 31e:	0ff7f793          	zext.b	a5,a5
 322:	4625                	li	a2,9
 324:	02f66863          	bltu	a2,a5,354 <atoi+0x44>
 328:	872a                	mv	a4,a0
  n = 0;
 32a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 32c:	0705                	add	a4,a4,1
 32e:	0025179b          	sllw	a5,a0,0x2
 332:	9fa9                	addw	a5,a5,a0
 334:	0017979b          	sllw	a5,a5,0x1
 338:	9fb5                	addw	a5,a5,a3
 33a:	fd07851b          	addw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 33e:	00074683          	lbu	a3,0(a4)
 342:	fd06879b          	addw	a5,a3,-48
 346:	0ff7f793          	zext.b	a5,a5
 34a:	fef671e3          	bgeu	a2,a5,32c <atoi+0x1c>
  return n;
}
 34e:	6422                	ld	s0,8(sp)
 350:	0141                	add	sp,sp,16
 352:	8082                	ret
  n = 0;
 354:	4501                	li	a0,0
 356:	bfe5                	j	34e <atoi+0x3e>

0000000000000358 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 358:	1141                	add	sp,sp,-16
 35a:	e422                	sd	s0,8(sp)
 35c:	0800                	add	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 35e:	02b57463          	bgeu	a0,a1,386 <memmove+0x2e>
    while(n-- > 0)
 362:	00c05f63          	blez	a2,380 <memmove+0x28>
 366:	1602                	sll	a2,a2,0x20
 368:	9201                	srl	a2,a2,0x20
 36a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 36e:	872a                	mv	a4,a0
      *dst++ = *src++;
 370:	0585                	add	a1,a1,1
 372:	0705                	add	a4,a4,1
 374:	fff5c683          	lbu	a3,-1(a1)
 378:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 37c:	fee79ae3          	bne	a5,a4,370 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 380:	6422                	ld	s0,8(sp)
 382:	0141                	add	sp,sp,16
 384:	8082                	ret
    dst += n;
 386:	00c50733          	add	a4,a0,a2
    src += n;
 38a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 38c:	fec05ae3          	blez	a2,380 <memmove+0x28>
 390:	fff6079b          	addw	a5,a2,-1
 394:	1782                	sll	a5,a5,0x20
 396:	9381                	srl	a5,a5,0x20
 398:	fff7c793          	not	a5,a5
 39c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 39e:	15fd                	add	a1,a1,-1
 3a0:	177d                	add	a4,a4,-1
 3a2:	0005c683          	lbu	a3,0(a1)
 3a6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3aa:	fee79ae3          	bne	a5,a4,39e <memmove+0x46>
 3ae:	bfc9                	j	380 <memmove+0x28>

00000000000003b0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3b0:	1141                	add	sp,sp,-16
 3b2:	e422                	sd	s0,8(sp)
 3b4:	0800                	add	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3b6:	ca05                	beqz	a2,3e6 <memcmp+0x36>
 3b8:	fff6069b          	addw	a3,a2,-1
 3bc:	1682                	sll	a3,a3,0x20
 3be:	9281                	srl	a3,a3,0x20
 3c0:	0685                	add	a3,a3,1
 3c2:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3c4:	00054783          	lbu	a5,0(a0)
 3c8:	0005c703          	lbu	a4,0(a1)
 3cc:	00e79863          	bne	a5,a4,3dc <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3d0:	0505                	add	a0,a0,1
    p2++;
 3d2:	0585                	add	a1,a1,1
  while (n-- > 0) {
 3d4:	fed518e3          	bne	a0,a3,3c4 <memcmp+0x14>
  }
  return 0;
 3d8:	4501                	li	a0,0
 3da:	a019                	j	3e0 <memcmp+0x30>
      return *p1 - *p2;
 3dc:	40e7853b          	subw	a0,a5,a4
}
 3e0:	6422                	ld	s0,8(sp)
 3e2:	0141                	add	sp,sp,16
 3e4:	8082                	ret
  return 0;
 3e6:	4501                	li	a0,0
 3e8:	bfe5                	j	3e0 <memcmp+0x30>

00000000000003ea <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3ea:	1141                	add	sp,sp,-16
 3ec:	e406                	sd	ra,8(sp)
 3ee:	e022                	sd	s0,0(sp)
 3f0:	0800                	add	s0,sp,16
  return memmove(dst, src, n);
 3f2:	00000097          	auipc	ra,0x0
 3f6:	f66080e7          	jalr	-154(ra) # 358 <memmove>
}
 3fa:	60a2                	ld	ra,8(sp)
 3fc:	6402                	ld	s0,0(sp)
 3fe:	0141                	add	sp,sp,16
 400:	8082                	ret

0000000000000402 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 402:	4885                	li	a7,1
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <exit>:
.global exit
exit:
 li a7, SYS_exit
 40a:	4889                	li	a7,2
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <wait>:
.global wait
wait:
 li a7, SYS_wait
 412:	488d                	li	a7,3
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 41a:	4891                	li	a7,4
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <read>:
.global read
read:
 li a7, SYS_read
 422:	4895                	li	a7,5
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <write>:
.global write
write:
 li a7, SYS_write
 42a:	48c1                	li	a7,16
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <close>:
.global close
close:
 li a7, SYS_close
 432:	48d5                	li	a7,21
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <kill>:
.global kill
kill:
 li a7, SYS_kill
 43a:	4899                	li	a7,6
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <exec>:
.global exec
exec:
 li a7, SYS_exec
 442:	489d                	li	a7,7
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <open>:
.global open
open:
 li a7, SYS_open
 44a:	48bd                	li	a7,15
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 452:	48c5                	li	a7,17
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 45a:	48c9                	li	a7,18
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 462:	48a1                	li	a7,8
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <link>:
.global link
link:
 li a7, SYS_link
 46a:	48cd                	li	a7,19
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 472:	48d1                	li	a7,20
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 47a:	48a5                	li	a7,9
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <dup>:
.global dup
dup:
 li a7, SYS_dup
 482:	48a9                	li	a7,10
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 48a:	48ad                	li	a7,11
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 492:	48b1                	li	a7,12
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 49a:	48b5                	li	a7,13
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4a2:	48b9                	li	a7,14
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4aa:	1101                	add	sp,sp,-32
 4ac:	ec06                	sd	ra,24(sp)
 4ae:	e822                	sd	s0,16(sp)
 4b0:	1000                	add	s0,sp,32
 4b2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4b6:	4605                	li	a2,1
 4b8:	fef40593          	add	a1,s0,-17
 4bc:	00000097          	auipc	ra,0x0
 4c0:	f6e080e7          	jalr	-146(ra) # 42a <write>
}
 4c4:	60e2                	ld	ra,24(sp)
 4c6:	6442                	ld	s0,16(sp)
 4c8:	6105                	add	sp,sp,32
 4ca:	8082                	ret

00000000000004cc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4cc:	7139                	add	sp,sp,-64
 4ce:	fc06                	sd	ra,56(sp)
 4d0:	f822                	sd	s0,48(sp)
 4d2:	f426                	sd	s1,40(sp)
 4d4:	f04a                	sd	s2,32(sp)
 4d6:	ec4e                	sd	s3,24(sp)
 4d8:	0080                	add	s0,sp,64
 4da:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4dc:	c299                	beqz	a3,4e2 <printint+0x16>
 4de:	0805c963          	bltz	a1,570 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4e2:	2581                	sext.w	a1,a1
  neg = 0;
 4e4:	4881                	li	a7,0
 4e6:	fc040693          	add	a3,s0,-64
  }

  i = 0;
 4ea:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4ec:	2601                	sext.w	a2,a2
 4ee:	00000517          	auipc	a0,0x0
 4f2:	4da50513          	add	a0,a0,1242 # 9c8 <digits>
 4f6:	883a                	mv	a6,a4
 4f8:	2705                	addw	a4,a4,1
 4fa:	02c5f7bb          	remuw	a5,a1,a2
 4fe:	1782                	sll	a5,a5,0x20
 500:	9381                	srl	a5,a5,0x20
 502:	97aa                	add	a5,a5,a0
 504:	0007c783          	lbu	a5,0(a5)
 508:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 50c:	0005879b          	sext.w	a5,a1
 510:	02c5d5bb          	divuw	a1,a1,a2
 514:	0685                	add	a3,a3,1
 516:	fec7f0e3          	bgeu	a5,a2,4f6 <printint+0x2a>
  if(neg)
 51a:	00088c63          	beqz	a7,532 <printint+0x66>
    buf[i++] = '-';
 51e:	fd070793          	add	a5,a4,-48
 522:	00878733          	add	a4,a5,s0
 526:	02d00793          	li	a5,45
 52a:	fef70823          	sb	a5,-16(a4)
 52e:	0028071b          	addw	a4,a6,2

  while(--i >= 0)
 532:	02e05863          	blez	a4,562 <printint+0x96>
 536:	fc040793          	add	a5,s0,-64
 53a:	00e78933          	add	s2,a5,a4
 53e:	fff78993          	add	s3,a5,-1
 542:	99ba                	add	s3,s3,a4
 544:	377d                	addw	a4,a4,-1
 546:	1702                	sll	a4,a4,0x20
 548:	9301                	srl	a4,a4,0x20
 54a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 54e:	fff94583          	lbu	a1,-1(s2)
 552:	8526                	mv	a0,s1
 554:	00000097          	auipc	ra,0x0
 558:	f56080e7          	jalr	-170(ra) # 4aa <putc>
  while(--i >= 0)
 55c:	197d                	add	s2,s2,-1
 55e:	ff3918e3          	bne	s2,s3,54e <printint+0x82>
}
 562:	70e2                	ld	ra,56(sp)
 564:	7442                	ld	s0,48(sp)
 566:	74a2                	ld	s1,40(sp)
 568:	7902                	ld	s2,32(sp)
 56a:	69e2                	ld	s3,24(sp)
 56c:	6121                	add	sp,sp,64
 56e:	8082                	ret
    x = -xx;
 570:	40b005bb          	negw	a1,a1
    neg = 1;
 574:	4885                	li	a7,1
    x = -xx;
 576:	bf85                	j	4e6 <printint+0x1a>

0000000000000578 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 578:	715d                	add	sp,sp,-80
 57a:	e486                	sd	ra,72(sp)
 57c:	e0a2                	sd	s0,64(sp)
 57e:	fc26                	sd	s1,56(sp)
 580:	f84a                	sd	s2,48(sp)
 582:	f44e                	sd	s3,40(sp)
 584:	f052                	sd	s4,32(sp)
 586:	ec56                	sd	s5,24(sp)
 588:	e85a                	sd	s6,16(sp)
 58a:	e45e                	sd	s7,8(sp)
 58c:	e062                	sd	s8,0(sp)
 58e:	0880                	add	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 590:	0005c903          	lbu	s2,0(a1)
 594:	18090c63          	beqz	s2,72c <vprintf+0x1b4>
 598:	8aaa                	mv	s5,a0
 59a:	8bb2                	mv	s7,a2
 59c:	00158493          	add	s1,a1,1
  state = 0;
 5a0:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5a2:	02500a13          	li	s4,37
 5a6:	4b55                	li	s6,21
 5a8:	a839                	j	5c6 <vprintf+0x4e>
        putc(fd, c);
 5aa:	85ca                	mv	a1,s2
 5ac:	8556                	mv	a0,s5
 5ae:	00000097          	auipc	ra,0x0
 5b2:	efc080e7          	jalr	-260(ra) # 4aa <putc>
 5b6:	a019                	j	5bc <vprintf+0x44>
    } else if(state == '%'){
 5b8:	01498d63          	beq	s3,s4,5d2 <vprintf+0x5a>
  for(i = 0; fmt[i]; i++){
 5bc:	0485                	add	s1,s1,1
 5be:	fff4c903          	lbu	s2,-1(s1)
 5c2:	16090563          	beqz	s2,72c <vprintf+0x1b4>
    if(state == 0){
 5c6:	fe0999e3          	bnez	s3,5b8 <vprintf+0x40>
      if(c == '%'){
 5ca:	ff4910e3          	bne	s2,s4,5aa <vprintf+0x32>
        state = '%';
 5ce:	89d2                	mv	s3,s4
 5d0:	b7f5                	j	5bc <vprintf+0x44>
      if(c == 'd'){
 5d2:	13490263          	beq	s2,s4,6f6 <vprintf+0x17e>
 5d6:	f9d9079b          	addw	a5,s2,-99
 5da:	0ff7f793          	zext.b	a5,a5
 5de:	12fb6563          	bltu	s6,a5,708 <vprintf+0x190>
 5e2:	f9d9079b          	addw	a5,s2,-99
 5e6:	0ff7f713          	zext.b	a4,a5
 5ea:	10eb6f63          	bltu	s6,a4,708 <vprintf+0x190>
 5ee:	00271793          	sll	a5,a4,0x2
 5f2:	00000717          	auipc	a4,0x0
 5f6:	37e70713          	add	a4,a4,894 # 970 <malloc+0x146>
 5fa:	97ba                	add	a5,a5,a4
 5fc:	439c                	lw	a5,0(a5)
 5fe:	97ba                	add	a5,a5,a4
 600:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 602:	008b8913          	add	s2,s7,8
 606:	4685                	li	a3,1
 608:	4629                	li	a2,10
 60a:	000ba583          	lw	a1,0(s7)
 60e:	8556                	mv	a0,s5
 610:	00000097          	auipc	ra,0x0
 614:	ebc080e7          	jalr	-324(ra) # 4cc <printint>
 618:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 61a:	4981                	li	s3,0
 61c:	b745                	j	5bc <vprintf+0x44>
        printint(fd, va_arg(ap, uint64), 10, 0);
 61e:	008b8913          	add	s2,s7,8
 622:	4681                	li	a3,0
 624:	4629                	li	a2,10
 626:	000ba583          	lw	a1,0(s7)
 62a:	8556                	mv	a0,s5
 62c:	00000097          	auipc	ra,0x0
 630:	ea0080e7          	jalr	-352(ra) # 4cc <printint>
 634:	8bca                	mv	s7,s2
      state = 0;
 636:	4981                	li	s3,0
 638:	b751                	j	5bc <vprintf+0x44>
        printint(fd, va_arg(ap, int), 16, 0);
 63a:	008b8913          	add	s2,s7,8
 63e:	4681                	li	a3,0
 640:	4641                	li	a2,16
 642:	000ba583          	lw	a1,0(s7)
 646:	8556                	mv	a0,s5
 648:	00000097          	auipc	ra,0x0
 64c:	e84080e7          	jalr	-380(ra) # 4cc <printint>
 650:	8bca                	mv	s7,s2
      state = 0;
 652:	4981                	li	s3,0
 654:	b7a5                	j	5bc <vprintf+0x44>
        printptr(fd, va_arg(ap, uint64));
 656:	008b8c13          	add	s8,s7,8
 65a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 65e:	03000593          	li	a1,48
 662:	8556                	mv	a0,s5
 664:	00000097          	auipc	ra,0x0
 668:	e46080e7          	jalr	-442(ra) # 4aa <putc>
  putc(fd, 'x');
 66c:	07800593          	li	a1,120
 670:	8556                	mv	a0,s5
 672:	00000097          	auipc	ra,0x0
 676:	e38080e7          	jalr	-456(ra) # 4aa <putc>
 67a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 67c:	00000b97          	auipc	s7,0x0
 680:	34cb8b93          	add	s7,s7,844 # 9c8 <digits>
 684:	03c9d793          	srl	a5,s3,0x3c
 688:	97de                	add	a5,a5,s7
 68a:	0007c583          	lbu	a1,0(a5)
 68e:	8556                	mv	a0,s5
 690:	00000097          	auipc	ra,0x0
 694:	e1a080e7          	jalr	-486(ra) # 4aa <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 698:	0992                	sll	s3,s3,0x4
 69a:	397d                	addw	s2,s2,-1
 69c:	fe0914e3          	bnez	s2,684 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 6a0:	8be2                	mv	s7,s8
      state = 0;
 6a2:	4981                	li	s3,0
 6a4:	bf21                	j	5bc <vprintf+0x44>
        s = va_arg(ap, char*);
 6a6:	008b8993          	add	s3,s7,8
 6aa:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 6ae:	02090163          	beqz	s2,6d0 <vprintf+0x158>
        while(*s != 0){
 6b2:	00094583          	lbu	a1,0(s2)
 6b6:	c9a5                	beqz	a1,726 <vprintf+0x1ae>
          putc(fd, *s);
 6b8:	8556                	mv	a0,s5
 6ba:	00000097          	auipc	ra,0x0
 6be:	df0080e7          	jalr	-528(ra) # 4aa <putc>
          s++;
 6c2:	0905                	add	s2,s2,1
        while(*s != 0){
 6c4:	00094583          	lbu	a1,0(s2)
 6c8:	f9e5                	bnez	a1,6b8 <vprintf+0x140>
        s = va_arg(ap, char*);
 6ca:	8bce                	mv	s7,s3
      state = 0;
 6cc:	4981                	li	s3,0
 6ce:	b5fd                	j	5bc <vprintf+0x44>
          s = "(null)";
 6d0:	00000917          	auipc	s2,0x0
 6d4:	29890913          	add	s2,s2,664 # 968 <malloc+0x13e>
        while(*s != 0){
 6d8:	02800593          	li	a1,40
 6dc:	bff1                	j	6b8 <vprintf+0x140>
        putc(fd, va_arg(ap, uint));
 6de:	008b8913          	add	s2,s7,8
 6e2:	000bc583          	lbu	a1,0(s7)
 6e6:	8556                	mv	a0,s5
 6e8:	00000097          	auipc	ra,0x0
 6ec:	dc2080e7          	jalr	-574(ra) # 4aa <putc>
 6f0:	8bca                	mv	s7,s2
      state = 0;
 6f2:	4981                	li	s3,0
 6f4:	b5e1                	j	5bc <vprintf+0x44>
        putc(fd, c);
 6f6:	02500593          	li	a1,37
 6fa:	8556                	mv	a0,s5
 6fc:	00000097          	auipc	ra,0x0
 700:	dae080e7          	jalr	-594(ra) # 4aa <putc>
      state = 0;
 704:	4981                	li	s3,0
 706:	bd5d                	j	5bc <vprintf+0x44>
        putc(fd, '%');
 708:	02500593          	li	a1,37
 70c:	8556                	mv	a0,s5
 70e:	00000097          	auipc	ra,0x0
 712:	d9c080e7          	jalr	-612(ra) # 4aa <putc>
        putc(fd, c);
 716:	85ca                	mv	a1,s2
 718:	8556                	mv	a0,s5
 71a:	00000097          	auipc	ra,0x0
 71e:	d90080e7          	jalr	-624(ra) # 4aa <putc>
      state = 0;
 722:	4981                	li	s3,0
 724:	bd61                	j	5bc <vprintf+0x44>
        s = va_arg(ap, char*);
 726:	8bce                	mv	s7,s3
      state = 0;
 728:	4981                	li	s3,0
 72a:	bd49                	j	5bc <vprintf+0x44>
    }
  }
}
 72c:	60a6                	ld	ra,72(sp)
 72e:	6406                	ld	s0,64(sp)
 730:	74e2                	ld	s1,56(sp)
 732:	7942                	ld	s2,48(sp)
 734:	79a2                	ld	s3,40(sp)
 736:	7a02                	ld	s4,32(sp)
 738:	6ae2                	ld	s5,24(sp)
 73a:	6b42                	ld	s6,16(sp)
 73c:	6ba2                	ld	s7,8(sp)
 73e:	6c02                	ld	s8,0(sp)
 740:	6161                	add	sp,sp,80
 742:	8082                	ret

0000000000000744 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 744:	715d                	add	sp,sp,-80
 746:	ec06                	sd	ra,24(sp)
 748:	e822                	sd	s0,16(sp)
 74a:	1000                	add	s0,sp,32
 74c:	e010                	sd	a2,0(s0)
 74e:	e414                	sd	a3,8(s0)
 750:	e818                	sd	a4,16(s0)
 752:	ec1c                	sd	a5,24(s0)
 754:	03043023          	sd	a6,32(s0)
 758:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 75c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 760:	8622                	mv	a2,s0
 762:	00000097          	auipc	ra,0x0
 766:	e16080e7          	jalr	-490(ra) # 578 <vprintf>
}
 76a:	60e2                	ld	ra,24(sp)
 76c:	6442                	ld	s0,16(sp)
 76e:	6161                	add	sp,sp,80
 770:	8082                	ret

0000000000000772 <printf>:

void
printf(const char *fmt, ...)
{
 772:	711d                	add	sp,sp,-96
 774:	ec06                	sd	ra,24(sp)
 776:	e822                	sd	s0,16(sp)
 778:	1000                	add	s0,sp,32
 77a:	e40c                	sd	a1,8(s0)
 77c:	e810                	sd	a2,16(s0)
 77e:	ec14                	sd	a3,24(s0)
 780:	f018                	sd	a4,32(s0)
 782:	f41c                	sd	a5,40(s0)
 784:	03043823          	sd	a6,48(s0)
 788:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 78c:	00840613          	add	a2,s0,8
 790:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 794:	85aa                	mv	a1,a0
 796:	4505                	li	a0,1
 798:	00000097          	auipc	ra,0x0
 79c:	de0080e7          	jalr	-544(ra) # 578 <vprintf>
}
 7a0:	60e2                	ld	ra,24(sp)
 7a2:	6442                	ld	s0,16(sp)
 7a4:	6125                	add	sp,sp,96
 7a6:	8082                	ret

00000000000007a8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a8:	1141                	add	sp,sp,-16
 7aa:	e422                	sd	s0,8(sp)
 7ac:	0800                	add	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ae:	ff050693          	add	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b2:	00001797          	auipc	a5,0x1
 7b6:	84e7b783          	ld	a5,-1970(a5) # 1000 <freep>
 7ba:	a02d                	j	7e4 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7bc:	4618                	lw	a4,8(a2)
 7be:	9f2d                	addw	a4,a4,a1
 7c0:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c4:	6398                	ld	a4,0(a5)
 7c6:	6310                	ld	a2,0(a4)
 7c8:	a83d                	j	806 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7ca:	ff852703          	lw	a4,-8(a0)
 7ce:	9f31                	addw	a4,a4,a2
 7d0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7d2:	ff053683          	ld	a3,-16(a0)
 7d6:	a091                	j	81a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d8:	6398                	ld	a4,0(a5)
 7da:	00e7e463          	bltu	a5,a4,7e2 <free+0x3a>
 7de:	00e6ea63          	bltu	a3,a4,7f2 <free+0x4a>
{
 7e2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e4:	fed7fae3          	bgeu	a5,a3,7d8 <free+0x30>
 7e8:	6398                	ld	a4,0(a5)
 7ea:	00e6e463          	bltu	a3,a4,7f2 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ee:	fee7eae3          	bltu	a5,a4,7e2 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7f2:	ff852583          	lw	a1,-8(a0)
 7f6:	6390                	ld	a2,0(a5)
 7f8:	02059813          	sll	a6,a1,0x20
 7fc:	01c85713          	srl	a4,a6,0x1c
 800:	9736                	add	a4,a4,a3
 802:	fae60de3          	beq	a2,a4,7bc <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 806:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 80a:	4790                	lw	a2,8(a5)
 80c:	02061593          	sll	a1,a2,0x20
 810:	01c5d713          	srl	a4,a1,0x1c
 814:	973e                	add	a4,a4,a5
 816:	fae68ae3          	beq	a3,a4,7ca <free+0x22>
    p->s.ptr = bp->s.ptr;
 81a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 81c:	00000717          	auipc	a4,0x0
 820:	7ef73223          	sd	a5,2020(a4) # 1000 <freep>
}
 824:	6422                	ld	s0,8(sp)
 826:	0141                	add	sp,sp,16
 828:	8082                	ret

000000000000082a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 82a:	7139                	add	sp,sp,-64
 82c:	fc06                	sd	ra,56(sp)
 82e:	f822                	sd	s0,48(sp)
 830:	f426                	sd	s1,40(sp)
 832:	f04a                	sd	s2,32(sp)
 834:	ec4e                	sd	s3,24(sp)
 836:	e852                	sd	s4,16(sp)
 838:	e456                	sd	s5,8(sp)
 83a:	e05a                	sd	s6,0(sp)
 83c:	0080                	add	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 83e:	02051493          	sll	s1,a0,0x20
 842:	9081                	srl	s1,s1,0x20
 844:	04bd                	add	s1,s1,15
 846:	8091                	srl	s1,s1,0x4
 848:	0014899b          	addw	s3,s1,1
 84c:	0485                	add	s1,s1,1
  if((prevp = freep) == 0){
 84e:	00000517          	auipc	a0,0x0
 852:	7b253503          	ld	a0,1970(a0) # 1000 <freep>
 856:	c515                	beqz	a0,882 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 858:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 85a:	4798                	lw	a4,8(a5)
 85c:	02977f63          	bgeu	a4,s1,89a <malloc+0x70>
  if(nu < 4096)
 860:	8a4e                	mv	s4,s3
 862:	0009871b          	sext.w	a4,s3
 866:	6685                	lui	a3,0x1
 868:	00d77363          	bgeu	a4,a3,86e <malloc+0x44>
 86c:	6a05                	lui	s4,0x1
 86e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 872:	004a1a1b          	sllw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 876:	00000917          	auipc	s2,0x0
 87a:	78a90913          	add	s2,s2,1930 # 1000 <freep>
  if(p == (char*)-1)
 87e:	5afd                	li	s5,-1
 880:	a895                	j	8f4 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 882:	00000797          	auipc	a5,0x0
 886:	78e78793          	add	a5,a5,1934 # 1010 <base>
 88a:	00000717          	auipc	a4,0x0
 88e:	76f73b23          	sd	a5,1910(a4) # 1000 <freep>
 892:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 894:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 898:	b7e1                	j	860 <malloc+0x36>
      if(p->s.size == nunits)
 89a:	02e48c63          	beq	s1,a4,8d2 <malloc+0xa8>
        p->s.size -= nunits;
 89e:	4137073b          	subw	a4,a4,s3
 8a2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8a4:	02071693          	sll	a3,a4,0x20
 8a8:	01c6d713          	srl	a4,a3,0x1c
 8ac:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8ae:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8b2:	00000717          	auipc	a4,0x0
 8b6:	74a73723          	sd	a0,1870(a4) # 1000 <freep>
      return (void*)(p + 1);
 8ba:	01078513          	add	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8be:	70e2                	ld	ra,56(sp)
 8c0:	7442                	ld	s0,48(sp)
 8c2:	74a2                	ld	s1,40(sp)
 8c4:	7902                	ld	s2,32(sp)
 8c6:	69e2                	ld	s3,24(sp)
 8c8:	6a42                	ld	s4,16(sp)
 8ca:	6aa2                	ld	s5,8(sp)
 8cc:	6b02                	ld	s6,0(sp)
 8ce:	6121                	add	sp,sp,64
 8d0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 8d2:	6398                	ld	a4,0(a5)
 8d4:	e118                	sd	a4,0(a0)
 8d6:	bff1                	j	8b2 <malloc+0x88>
  hp->s.size = nu;
 8d8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8dc:	0541                	add	a0,a0,16
 8de:	00000097          	auipc	ra,0x0
 8e2:	eca080e7          	jalr	-310(ra) # 7a8 <free>
  return freep;
 8e6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8ea:	d971                	beqz	a0,8be <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ec:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ee:	4798                	lw	a4,8(a5)
 8f0:	fa9775e3          	bgeu	a4,s1,89a <malloc+0x70>
    if(p == freep)
 8f4:	00093703          	ld	a4,0(s2)
 8f8:	853e                	mv	a0,a5
 8fa:	fef719e3          	bne	a4,a5,8ec <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 8fe:	8552                	mv	a0,s4
 900:	00000097          	auipc	ra,0x0
 904:	b92080e7          	jalr	-1134(ra) # 492 <sbrk>
  if(p == (char*)-1)
 908:	fd5518e3          	bne	a0,s5,8d8 <malloc+0xae>
        return 0;
 90c:	4501                	li	a0,0
 90e:	bf45                	j	8be <malloc+0x94>
