import { defineCollection, z } from 'astro:content';

const posts = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    publishDate: z.date(),
    description: z.string().optional(),
    tags: z.array(z.string()).optional(),
    source: z.string().optional(),
    category: z.enum(['游戏动态', 'IT动态']).optional(),
  }),
});

export const collections = { posts };
