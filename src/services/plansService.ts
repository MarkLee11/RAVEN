import { Plan, PlanMember, PlanRequest } from '../contracts/types';
import { plans, planMembers } from '../data/plans';

export const plansService = {
  async listPlans(): Promise<Plan[]> {
    await new Promise(resolve => setTimeout(resolve, 250));
    
    return plans.sort((a, b) => a.createdAt.getTime() - b.createdAt.getTime());
  },

  async getPlan(id: string): Promise<Plan | null> {
    await new Promise(resolve => setTimeout(resolve, 200));
    
    const plan = plans.find(p => p.id === id);
    return plan || null;
  },

  async getPlanMembers(planId: string): Promise<PlanMember[]> {
    await new Promise(resolve => setTimeout(resolve, 150));
    
    return planMembers.filter(member => member.planId === planId);
  },

  async joinPlan(request: PlanRequest): Promise<{ success: boolean; member?: PlanMember }> {
    await new Promise(resolve => setTimeout(resolve, 400));
    
    const plan = plans.find(p => p.id === request.planId);
    if (!plan) {
      return { success: false };
    }
    
    const currentCount = planMembers.filter(m => m.planId === request.planId).length;
    if (currentCount >= plan.maxMembers) {
      return { success: false };
    }
    
    const newMember: PlanMember = {
      id: `pm_${Date.now()}`,
      planId: request.planId,
      name: request.memberName,
      joinedAt: new Date(),
    };
    
    // In real app, this would persist to backend
    console.log('Joined plan:', newMember);
    
    return { success: true, member: newMember };
  },
};